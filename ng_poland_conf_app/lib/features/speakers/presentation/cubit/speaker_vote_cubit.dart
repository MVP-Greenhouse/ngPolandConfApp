import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/user_session_cubit.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/speaker_vote_value.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/engagement_visibility.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/latest_conference_resolver.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/speaker_vote_toggle.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/engagement_config_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/speaker_vote_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'speaker_vote_state.dart';
part 'speaker_vote_cubit.freezed.dart';

@injectable
class SpeakerVoteCubit extends Cubit<SpeakerVoteState> {
  SpeakerVoteCubit(
    this._speakerVoteRepository,
    this._configRepository,
    this._userSessionCubit,
    this._conferencesCubit,
    @factoryParam this.speakerId,
  ) : super(const SpeakerVoteState.hidden()) {
    _listen();
  }

  final SpeakerVoteRepository _speakerVoteRepository;
  final EngagementConfigRepository _configRepository;
  final UserSessionCubit _userSessionCubit;
  final ConferencesCubit _conferencesCubit;
  final String speakerId;

  StreamSubscription<SpeakerVoteState>? _subscription;

  bool requiresLogin() =>
      state.maybeWhen(needsLogin: () => true, orElse: () => false);

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
                if (_shouldIgnoreWatchMyVote(next)) return;
                emit(next);
              },
              onError: (_) {
                if (!isClosed) emit(const SpeakerVoteState.hidden());
              },
            );
  }

  Stream<SpeakerVoteState> _mapToState(
    ({ConferencesState conferences, UserSessionState session}) snapshot,
  ) {
    final loaded = snapshot.conferences.mapOrNull(loaded: (state) => state);
    if (loaded == null) {
      return Stream.value(const SpeakerVoteState.hidden());
    }

    final selectedConfId = loaded.selectedConference.confId;
    final latestConfId = LatestConferenceResolver.fromConfIds(
      loaded.conferences.list.map((conference) => conference.confId),
    );
    if (latestConfId == null) {
      return Stream.value(const SpeakerVoteState.hidden());
    }

    return _configRepository.watchConfig(latestConfId).switchMap((config) {
      final showVoting = EngagementVisibility.showVoting(
        selectedConfId: selectedConfId,
        latestConfId: latestConfId,
        votingOpen: config.isVotingOpen(DateTime.now()),
      );
      if (!showVoting) {
        return Stream<SpeakerVoteState>.value(const SpeakerVoteState.hidden());
      }

      final uid = snapshot.session.profile?.uid;
      if (uid == null) {
        return Stream<SpeakerVoteState>.value(
          const SpeakerVoteState.needsLogin(),
        );
      }

      return _speakerVoteRepository
          .watchMyVote(confId: selectedConfId, speakerId: speakerId, uid: uid)
          .map(SpeakerVoteState.ready);
    });
  }

  bool _shouldIgnoreWatchMyVote(SpeakerVoteState next) {
    final inFlight = state.maybeWhen(
      saving: (_) => true,
      failure: (_) => true,
      orElse: () => false,
    );
    if (!inFlight) return false;
    return next.maybeWhen(ready: (_) => true, orElse: () => false);
  }

  Future<void> tap(SpeakerVoteValue tapped) async {
    if (requiresLogin()) return;

    final votable = state.maybeWhen(
      ready: (_) => true,
      failure: (_) => true,
      orElse: () => false,
    );
    if (!votable) return;

    final previous = state.vote;
    final uid = _userSessionCubit.state.profile?.uid;
    final confId =
        _conferencesCubit.state.mapOrNull(
          loaded: (value) => value.selectedConference.confId,
        ) ??
        _conferencesCubit.selectedConference?.confId;
    if (uid == null || confId == null) return;

    final next = SpeakerVoteToggle.apply(current: previous, tapped: tapped);
    emit(SpeakerVoteState.saving(previous));
    try {
      await _speakerVoteRepository.setVote(
        confId: confId,
        speakerId: speakerId,
        uid: uid,
        value: next,
      );
      if (!isClosed) emit(SpeakerVoteState.ready(next));
    } catch (_) {
      if (!isClosed) emit(SpeakerVoteState.failure(previous));
    }
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
