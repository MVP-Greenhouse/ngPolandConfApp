import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/user_session_cubit.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/engagement_visibility.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/event_vote_ranking.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/event_vote_toggle.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/latest_conference_resolver.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/engagement_config_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/event_vote_repository.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/logic/conference_datetime.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/usecases/get_all_events_for_conference.dart';
import 'package:rxdart/rxdart.dart';

part 'schedule_top5_state.dart';

@injectable
class ScheduleTop5Cubit extends Cubit<ScheduleTop5State> {
  ScheduleTop5Cubit(
    this._configRepository,
    this._eventVoteRepository,
    this._conferencesCubit,
    this._userSessionCubit,
    this._getAllEvents,
  ) : super(const ScheduleTop5State.loading());

  final EngagementConfigRepository _configRepository;
  final EventVoteRepository _eventVoteRepository;
  final ConferencesCubit _conferencesCubit;
  final UserSessionCubit _userSessionCubit;
  final GetAllEventsForConference _getAllEvents;

  StreamSubscription<ScheduleTop5State>? _subscription;
  EventItemType _track = EventItemType.ngPoland;

  void load({required EventItemType track}) {
    _track = track;
    _subscription?.cancel();
    if (!isClosed) emit(const ScheduleTop5State.loading());
    _subscription =
        Rx.combineLatest2(
              _conferencesCubit.stream.startWith(_conferencesCubit.state),
              _userSessionCubit.stream.startWith(_userSessionCubit.state),
              (ConferencesState conferences, UserSessionState session) =>
                  (conferences: conferences, session: session),
            )
            .switchMap(_streamTop5)
            .listen(
              (next) {
                if (!isClosed) emit(next);
              },
              onError: (_) {
                if (!isClosed) emit(const ScheduleTop5State.hidden());
              },
            );
  }

  Stream<ScheduleTop5State> _streamTop5(
    ({ConferencesState conferences, UserSessionState session}) snapshot,
  ) {
    final loaded = snapshot.conferences.mapOrNull(loaded: (state) => state);
    if (loaded == null) {
      return Stream.value(const ScheduleTop5State.loading());
    }

    final selectedConfId = loaded.selectedConference.confId;
    final latestConfId = LatestConferenceResolver.fromConfIds(
      loaded.conferences.list.map((conference) => conference.confId),
    );
    if (latestConfId == null) {
      return Stream.value(const ScheduleTop5State.hidden());
    }

    final uid = snapshot.session.profile?.uid;

    return _configRepository.watchConfig(latestConfId).switchMap((config) {
      final trackConfig = config.forTrack(_track);
      final show = EngagementVisibility.showTop5(
        selectedConfId: selectedConfId,
        latestConfId: latestConfId,
        top5Enabled: trackConfig.top5Enabled,
      );
      if (!show) {
        return Stream.value(const ScheduleTop5State.hidden());
      }

      final votingOpen = EngagementVisibility.showVoting(
        selectedConfId: selectedConfId,
        latestConfId: latestConfId,
        votingOpen: trackConfig.isVotingOpen(DateTime.now()),
      );

      // Emit loading while ranking resolves — otherwise UI stays on the
      // previous state (often initial hidden → empty placeholder).
      return Stream.fromFuture(_loadRanking(selectedConfId))
          .asyncExpand((top) async* {
            if (top.isEmpty) {
              yield ScheduleTop5State.empty(
                track: _track,
                confId: selectedConfId,
                votingOpen: votingOpen,
              );
              return;
            }

            if (uid == null) {
              yield ScheduleTop5State.loaded(
                top: top,
                track: _track,
                confId: selectedConfId,
                votingOpen: votingOpen,
              );
              return;
            }

            yield* _watchMyLikes(
              confId: selectedConfId,
              uid: uid,
              eventIds: top.map((entry) => entry.eventId),
            ).map(
              (likedIds) => ScheduleTop5State.loaded(
                top: top,
                track: _track,
                confId: selectedConfId,
                votingOpen: votingOpen,
                myLikedEventIds: likedIds,
              ),
            );
          })
          .startWith(const ScheduleTop5State.loading());
    });
  }

  Future<List<EventVoteRank>> _loadRanking(String confId) async {
    try {
      final events = await _getAllEvents.call(
        Params(
          eventItemType: _track.name,
          confId: confId,
          limit: 1000,
        ),
      );
      final counts = await _eventVoteRepository.loadVoteCounts(confId);
      final entries = [
        for (final event in events)
          if (event.speaker != null)
            EventVoteRank(
              eventId: event.id,
              title: event.title,
              speakerName: event.speaker?.name ?? '',
              trackType: event.type,
              likes: counts[event.id]?.likes ?? 0,
              timeLabel: _timeLabel(event.startDate, event.endDate),
            ),
      ];
      return EventVoteRanking.topForTrack(
        input: entries,
        trackType: _track.name,
      );
    } catch (_) {
      return const [];
    }
  }

  Stream<Set<String>> _watchMyLikes({
    required String confId,
    required String uid,
    required Iterable<String> eventIds,
  }) {
    final ids = eventIds.toList();
    if (ids.isEmpty) return Stream.value(const <String>{});

    return Rx.combineLatestList([
      for (final eventId in ids)
        _eventVoteRepository
            .watchMyLike(confId: confId, eventId: eventId, uid: uid)
            .map((liked) => MapEntry(eventId, liked)),
    ]).map((entries) {
      return {
        for (final entry in entries)
          if (entry.value) entry.key,
      };
    });
  }

  static String _timeLabel(DateTime? start, DateTime? end) {
    if (start == null || end == null) return '';
    return '${ConferenceDateTime.formatHm(start)} — ${ConferenceDateTime.formatHm(end)}';
  }

  bool get requiresLogin => _userSessionCubit.state.profile?.uid == null;

  Future<void> toggleLike(String eventId) async {
    if (requiresLogin) return;
    final loaded = switch (state) {
      final _Loaded value => value,
      _ => null,
    };
    if (loaded == null || !loaded.votingOpen) return;

    final uid = _userSessionCubit.state.profile?.uid;
    if (uid == null) return;

    final currentlyLiked = loaded.myLikedEventIds.contains(eventId);
    final nextLiked = EventVoteToggle.apply(currentlyLiked: currentlyLiked);

    _emitLikedOptimistic(
      current: loaded,
      eventId: eventId,
      liked: nextLiked,
    );

    try {
      await _eventVoteRepository.setLike(
        confId: loaded.confId,
        eventId: eventId,
        uid: uid,
        liked: nextLiked,
      );
    } catch (_) {
      _emitLikedOptimistic(
        current: loaded,
        eventId: eventId,
        liked: currentlyLiked,
      );
      rethrow;
    }
  }

  void _emitLikedOptimistic({
    required _Loaded current,
    required String eventId,
    required bool liked,
  }) {
    final nextIds = {...current.myLikedEventIds};
    final wasLiked = nextIds.contains(eventId);
    if (liked) {
      nextIds.add(eventId);
    } else {
      nextIds.remove(eventId);
    }

    final nextTop = [
      for (final entry in current.top)
        if (entry.eventId == eventId)
          EventVoteRank(
            eventId: entry.eventId,
            title: entry.title,
            speakerName: entry.speakerName,
            trackType: entry.trackType,
            likes: nextOptimisticLikes(
              liked: liked,
              wasLiked: wasLiked,
              currentLikes: entry.likes,
            ),
            timeLabel: entry.timeLabel,
          )
        else
          entry,
    ];

    emit(
      ScheduleTop5State.loaded(
        top: nextTop,
        track: current.track,
        confId: current.confId,
        votingOpen: current.votingOpen,
        myLikedEventIds: nextIds,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
