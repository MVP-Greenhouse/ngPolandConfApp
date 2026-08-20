import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/user_session_cubit.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_participant.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_status.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_winner.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/contest_draw.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/latest_conference_resolver.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/speaker_vote_ranking.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/contest_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/engagement_config_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/speaker_vote_repository.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/usecases/get_all_speakers_for_conference.dart';
import 'package:rxdart/rxdart.dart';

part 'admin_state.dart';
part 'admin_cubit.freezed.dart';

@injectable
class AdminCubit extends Cubit<AdminState> {
  AdminCubit(
    this._configRepository,
    this._speakerVoteRepository,
    this._contestRepository,
    this._getAllSpeakers,
    this._userSessionCubit,
    this._conferencesCubit,
  ) : super(const AdminState()) {
    _listen();
  }

  final EngagementConfigRepository _configRepository;
  final SpeakerVoteRepository _speakerVoteRepository;
  final ContestRepository _contestRepository;
  final GetAllSpeakersForConference _getAllSpeakers;
  final UserSessionCubit _userSessionCubit;
  final ConferencesCubit _conferencesCubit;

  StreamSubscription<AdminState>? _subscription;

  void _listen() {
    final conferences$ = _conferencesCubit.stream.startWith(
      _conferencesCubit.state,
    );
    final session$ = _userSessionCubit.stream.startWith(
      _userSessionCubit.state,
    );

    _subscription =
        Rx.combineLatest2(
              conferences$,
              session$,
              (ConferencesState conferences, UserSessionState session) =>
                  (conferences: conferences, session: session),
            )
            .switchMap(_mapToState)
            .listen(
              (next) {
                if (isClosed) return;
                if (state.message != null) {
                  emit(next.copyWith(message: state.message));
                  return;
                }
                emit(next);
              },
              onError: (_) {},
            );
  }

  Stream<AdminState> _mapToState(
    ({ConferencesState conferences, UserSessionState session}) snapshot,
  ) {
    if (!snapshot.session.isAdmin) {
      return Stream.value(const AdminState());
    }

    final loaded = snapshot.conferences.mapOrNull(loaded: (state) => state);
    if (loaded == null) {
      return Stream.value(const AdminState(isAdmin: true, loading: true));
    }

    final latestConfId = LatestConferenceResolver.fromConfIds(
      loaded.conferences.list.map((conference) => conference.confId),
    );
    if (latestConfId == null) {
      return Stream.value(const AdminState(isAdmin: true));
    }

    final ranking$ = Stream.fromFuture(
      _loadRanking(latestConfId),
    ).startWith(const <SpeakerVoteRank>[]);

    return Rx.combineLatest4(
      _configRepository.watchConfig(latestConfId),
      _contestRepository.watchParticipants(latestConfId),
      _contestRepository.watchWinners(latestConfId),
      ranking$,
      (
        EngagementConfig config,
        List<ContestParticipant> participants,
        List<ContestWinner> winners,
        List<SpeakerVoteRank> ranking,
      ) => AdminState(
        isAdmin: true,
        latestConfId: latestConfId,
        config: config,
        ranking: ranking,
        participants: participants,
        winners: winners,
      ),
    );
  }

  Future<List<SpeakerVoteRank>> _loadRanking(String confId) async {
    try {
      final speakers = await _getAllSpeakers.call(
        Params(confId: confId, limit: 1000),
      );
      final counts = await _speakerVoteRepository.loadVoteCounts(confId);
      return SpeakerVoteRanking.sort([
        for (final speaker in speakers)
          SpeakerVoteRank(
            speakerId: speaker.id ?? '',
            name: speaker.name ?? '',
            up: counts[speaker.id ?? '']?.up ?? 0,
            down: counts[speaker.id ?? '']?.down ?? 0,
          ),
      ]);
    } catch (_) {
      return const [];
    }
  }

  Future<void> saveVoting({
    required bool enabled,
    required DateTime start,
    required DateTime end,
  }) async {
    final confId = state.latestConfId;
    final config = state.config;
    if (confId == null || config == null) return;
    await _configRepository.saveConfig(
      confId,
      config.copyWith(
        votingEnabled: enabled,
        votingStartsAt: start.toUtc(),
        votingEndsAt: end.toUtc(),
      ),
    );
  }

  Future<void> saveContest({
    required bool enabled,
    required DateTime start,
    required DateTime end,
  }) async {
    final confId = state.latestConfId;
    final config = state.config;
    if (confId == null || config == null) return;
    var next = config.copyWith(
      contestEnabled: enabled,
      contestStartsAt: start.toUtc(),
      contestEndsAt: end.toUtc(),
    );
    if (enabled && config.contestStatus == ContestStatus.idle) {
      next = next.copyWith(contestStatus: ContestStatus.open);
    }
    await _configRepository.saveConfig(confId, next);
  }

  Future<void> draw({required int count, required Random random}) async {
    final confId = state.latestConfId;
    if (confId == null) return;

    final picked = ContestDraw.pick(
      participantIds: state.participants.map((p) => p.uid).toList(),
      winnerIds: state.winners.map((w) => w.uid).toSet(),
      count: count,
      random: random,
    );
    if (picked.isEmpty) {
      if (!isClosed) {
        emit(state.copyWith(message: 'Brak osób do wylosowania'));
      }
      return;
    }

    final byUid = {for (final p in state.participants) p.uid: p};
    var order = state.winners.length + 1;
    final winners = <ContestWinner>[
      for (final uid in picked)
        ContestWinner(
          uid: uid,
          displayName: _orMissing(byUid[uid]?.displayName),
          email: _orMissing(byUid[uid]?.email),
          order: order++,
        ),
    ];
    await _contestRepository.saveWinners(confId: confId, winners: winners);

    final status = state.config?.contestStatus;
    if (status == ContestStatus.idle || status == ContestStatus.open) {
      await _contestRepository.updateContestStatus(
        confId: confId,
        status: ContestStatus.drawing,
      );
    }
  }

  Future<void> finishDrawing() async {
    final confId = state.latestConfId;
    if (confId == null) return;
    if (state.config?.contestStatus != ContestStatus.drawing) return;
    await _contestRepository.updateContestStatus(
      confId: confId,
      status: ContestStatus.finished,
    );
  }

  void clearMessage() {
    if (!isClosed && state.message != null) {
      emit(state.copyWith(message: null));
    }
  }

  static String _orMissing(String? value) {
    final trimmed = value?.trim() ?? '';
    return trimmed.isEmpty ? 'brak danych' : trimmed;
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
