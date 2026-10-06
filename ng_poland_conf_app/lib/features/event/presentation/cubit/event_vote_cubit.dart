import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/user_session_cubit.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/engagement_visibility.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/event_vote_toggle.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/latest_conference_resolver.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/engagement_config_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/event_vote_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'event_vote_state.dart';
part 'event_vote_cubit.freezed.dart';

@injectable
class EventVoteCubit extends Cubit<EventVoteState> {
  EventVoteCubit(
    this._eventVoteRepository,
    this._configRepository,
    this._userSessionCubit,
    this._conferencesCubit,
    @factoryParam this.eventId,
    @factoryParam this.trackName,
  ) : super(const EventVoteState.hidden()) {
    _listen();
  }

  final EventVoteRepository _eventVoteRepository;
  final EngagementConfigRepository _configRepository;
  final UserSessionCubit _userSessionCubit;
  final ConferencesCubit _conferencesCubit;
  final String eventId;
  final String trackName;

  StreamSubscription<EventVoteState>? _subscription;

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
                if (_shouldIgnoreWatchMyLike(next)) return;
                emit(next);
              },
              onError: (_) {
                if (!isClosed) emit(const EventVoteState.hidden());
              },
            );
  }

  Stream<EventVoteState> _mapToState(
    ({ConferencesState conferences, UserSessionState session}) snapshot,
  ) {
    final loaded = snapshot.conferences.mapOrNull(loaded: (state) => state);
    if (loaded == null) {
      return Stream.value(const EventVoteState.hidden());
    }

    final selectedConfId = loaded.selectedConference.confId;
    final latestConfId = LatestConferenceResolver.fromConfIds(
      loaded.conferences.list.map((conference) => conference.confId),
    );
    if (latestConfId == null) {
      return Stream.value(const EventVoteState.hidden());
    }

    return _configRepository.watchConfig(latestConfId).switchMap((config) {
      final track = EventItemType.values.firstWhere(
        (type) => type.name == trackName,
        orElse: () => EventItemType.ngPoland,
      );
      final showVoting = EngagementVisibility.showVoting(
        selectedConfId: selectedConfId,
        latestConfId: latestConfId,
        votingOpen: config.forTrack(track).isVotingOpen(DateTime.now()),
      );
      if (!showVoting) {
        return Stream<EventVoteState>.value(const EventVoteState.hidden());
      }

      return snapshot.session.when(
        loading: () => Stream<EventVoteState>.value(
          const EventVoteState.hidden(),
        ),
        unauthenticated: () => Stream<EventVoteState>.value(
          const EventVoteState.needsLogin(),
        ),
        authenticated: (profile) => _eventVoteRepository
            .watchMyLike(
              confId: selectedConfId,
              eventId: eventId,
              uid: profile.uid,
            )
            .map(EventVoteState.ready)
            .startWith(const EventVoteState.hidden()),
      );
    });
  }

  bool _shouldIgnoreWatchMyLike(EventVoteState next) {
    final inFlight = state.maybeWhen(
      saving: (_) => true,
      failure: (_) => true,
      orElse: () => false,
    );
    if (!inFlight) return false;
    return next.maybeWhen(ready: (_) => true, orElse: () => false);
  }

  Future<void> toggleLike() async {
    if (requiresLogin()) return;

    final votable = state.maybeWhen(
      ready: (_) => true,
      failure: (_) => true,
      orElse: () => false,
    );
    if (!votable) return;

    final previousLiked = state.liked;
    final uid = _userSessionCubit.state.profile?.uid;
    final confId =
        _conferencesCubit.state.mapOrNull(
          loaded: (value) => value.selectedConference.confId,
        ) ??
        _conferencesCubit.selectedConference?.confId;
    if (uid == null || confId == null) return;

    final nextLiked = EventVoteToggle.apply(currentlyLiked: previousLiked);
    emit(EventVoteState.saving(previousLiked));
    try {
      await _eventVoteRepository.setLike(
        confId: confId,
        eventId: eventId,
        uid: uid,
        liked: nextLiked,
      );
      if (!isClosed) emit(EventVoteState.ready(nextLiked));
    } catch (_) {
      if (!isClosed) emit(EventVoteState.failure(previousLiked));
    }
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
