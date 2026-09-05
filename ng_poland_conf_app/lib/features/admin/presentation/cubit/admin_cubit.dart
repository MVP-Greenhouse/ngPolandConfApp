import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/user_session_cubit.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_history_entry.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_participant.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_status.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_winner.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/contest_archive.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/contest_draw.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/latest_conference_resolver.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/speaker_vote_ranking.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/start_new_contest_guard.dart';
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
  ) : super(_seedState(_userSessionCubit, _conferencesCubit)) {
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
                var merged = next;
                if (state.message != null) {
                  merged = merged.copyWith(message: state.message);
                }
                emit(_retainContestStatus(state, merged));
              },
              onError: (Object error, StackTrace stackTrace) {
                if (isClosed) return;
                emit(state.copyWith(message: error.toString(), loading: false));
              },
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

    return Rx.combineLatest5(
      _configRepository.watchConfig(latestConfId),
      _contestRepository.watchParticipants(latestConfId),
      _contestRepository.watchWinners(latestConfId),
      _contestRepository.watchHistory(latestConfId),
      ranking$,
      (
        EngagementConfig config,
        List<ContestParticipant> participants,
        List<ContestWinner> winners,
        List<ContestHistoryEntry> history,
        List<SpeakerVoteRank> ranking,
      ) => AdminState(
        isAdmin: true,
        latestConfId: latestConfId,
        config: config,
        ranking: ranking,
        participants: participants,
        winners: winners,
        history: history,
      ),
    ).startWith(
      AdminState(isAdmin: true, loading: true, latestConfId: latestConfId),
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
        contestStatus: state.config?.contestStatus ?? config.contestStatus,
      ),
    );
  }

  Future<void> saveContest({
    required bool enabled,
    required DateTime start,
    required DateTime end,
    required String name,
  }) async {
    final confId = state.latestConfId;
    final config = state.config;
    if (confId == null || config == null) return;
    final contestStatus = state.config?.contestStatus ?? config.contestStatus;
    final trimmedName = name.trim();
    if (enabled && contestStatus == ContestStatus.idle && trimmedName.isEmpty) {
      emit(state.copyWith(message: 'Podaj nazwę konkursu'));
      return;
    }
    var next = config.copyWith(
      contestEnabled: enabled,
      contestStartsAt: start.toUtc(),
      contestEndsAt: end.toUtc(),
      contestStatus: contestStatus,
      contestName: trimmedName,
    );
    if (enabled && contestStatus == ContestStatus.idle) {
      next = next.copyWith(
        contestId: config.contestId.isEmpty
            ? 'c_${DateTime.now().toUtc().millisecondsSinceEpoch}'
            : config.contestId,
        contestStatus: ContestStatus.open,
      );
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
      _emitContestStatus(ContestStatus.drawing);
    }
  }

  Future<void> finishDrawing() async {
    final confId = state.latestConfId;
    final config = state.config;
    if (confId == null || config == null) return;
    if (config.contestStatus != ContestStatus.drawing) return;

    var contestId = config.contestId;
    if (contestId.isEmpty) {
      contestId = 'c_${DateTime.now().toUtc().millisecondsSinceEpoch}';
      await _configRepository.saveConfig(
        confId,
        config.copyWith(contestId: contestId),
      );
    }

    final entry = ContestArchive.buildEntry(
      contestId: contestId,
      name: config.contestName.isEmpty ? 'Konkurs' : config.contestName,
      startsAt: config.contestStartsAt,
      endsAt: config.contestEndsAt,
      finishedAt: DateTime.now().toUtc(),
      winners: state.winners,
    );
    await _contestRepository.archiveContestIfAbsent(
      confId: confId,
      entry: entry,
    );
    await _contestRepository.updateContestStatus(
      confId: confId,
      status: ContestStatus.finished,
    );
    _emitContestStatus(ContestStatus.finished);
  }

  Future<void> startNewContest({
    required String name,
    required bool carryParticipants,
  }) async {
    final confId = state.latestConfId;
    final config = state.config;
    if (confId == null || config == null) return;
    final error = StartNewContestGuard.validate(
      status: config.contestStatus,
      name: name,
    );
    if (error != null) {
      emit(state.copyWith(message: error));
      return;
    }

    if (config.contestId.isNotEmpty) {
      await _contestRepository.archiveContestIfAbsent(
        confId: confId,
        entry: ContestArchive.buildEntry(
          contestId: config.contestId,
          name: config.contestName.isEmpty ? 'Konkurs' : config.contestName,
          startsAt: config.contestStartsAt,
          endsAt: config.contestEndsAt,
          finishedAt: DateTime.now().toUtc(),
          winners: state.winners,
        ),
      );
    }

    await _contestRepository.clearWinners(confId);
    if (!carryParticipants) {
      await _contestRepository.clearParticipants(confId);
    }

    final nextId = 'c_${DateTime.now().toUtc().millisecondsSinceEpoch}';
    final next = config.copyWith(
      contestId: nextId,
      contestName: name.trim(),
      contestStatus: ContestStatus.open,
      contestEnabled: true,
    );
    await _configRepository.saveConfig(confId, next);
  }

  void clearMessage() {
    if (!isClosed && state.message != null) {
      emit(state.copyWith(message: null));
    }
  }

  void _emitContestStatus(ContestStatus status) {
    if (isClosed) return;
    final config = state.config;
    if (config == null) return;
    emit(state.copyWith(config: config.copyWith(contestStatus: status)));
  }

  static AdminState _seedState(
    UserSessionCubit session,
    ConferencesCubit conferences,
  ) {
    if (!session.state.isAdmin) return const AdminState();
    return AdminState(
      isAdmin: true,
      loading: true,
      latestConfId: _latestConfId(conferences.state),
    );
  }

  static String? _latestConfId(ConferencesState conferences) {
    final loaded = conferences.mapOrNull(loaded: (state) => state);
    if (loaded == null) return null;
    return LatestConferenceResolver.fromConfIds(
      loaded.conferences.list.map((conference) => conference.confId),
    );
  }

  static AdminState _retainContestStatus(AdminState current, AdminState next) {
    final currentStatus = current.config?.contestStatus;
    final nextConfig = next.config;
    if (currentStatus == null || nextConfig == null) return next;
    if (current.config?.contestId != nextConfig.contestId) return next;
    if (_statusPriority(currentStatus) <=
        _statusPriority(nextConfig.contestStatus)) {
      return next;
    }
    return next.copyWith(
      config: nextConfig.copyWith(contestStatus: currentStatus),
    );
  }

  static int _statusPriority(ContestStatus status) => switch (status) {
    ContestStatus.idle => 0,
    ContestStatus.open => 1,
    ContestStatus.drawing => 2,
    ContestStatus.finished => 3,
  };

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
