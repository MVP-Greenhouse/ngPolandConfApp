import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/user_session_cubit.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/event_vote_ranking.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/latest_conference_resolver.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/engagement_config_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/event_vote_repository.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/usecases/get_all_events_for_conference.dart';
import 'package:rxdart/rxdart.dart';

part 'admin_state.dart';

@injectable
class AdminCubit extends Cubit<AdminState> {
  AdminCubit(
    this._configRepository,
    this._eventVoteRepository,
    this._getAllEvents,
    this._userSessionCubit,
    this._conferencesCubit,
  ) : super(_seedState(_userSessionCubit, _conferencesCubit)) {
    _selectedConfId$.add(state.selectedConfId);
    _selectedTrack$.add(state.selectedTrack);
    _listen();
  }

  final EngagementConfigRepository _configRepository;
  final EventVoteRepository _eventVoteRepository;
  final GetAllEventsForConference _getAllEvents;
  final UserSessionCubit _userSessionCubit;
  final ConferencesCubit _conferencesCubit;

  final BehaviorSubject<String?> _selectedConfId$ =
      BehaviorSubject<String?>.seeded(null);
  final BehaviorSubject<EventItemType> _selectedTrack$ =
      BehaviorSubject<EventItemType>.seeded(EventItemType.ngPoland);

  StreamSubscription<AdminState>? _subscription;

  void selectConference(String confId) {
    if (_selectedConfId$.value == confId) return;
    _selectedConfId$.add(confId);
  }

  void selectTrack(EventItemType track) {
    if (_selectedTrack$.value == track) return;
    _selectedTrack$.add(track);
  }

  void _listen() {
    final conferences$ = _conferencesCubit.stream.startWith(
      _conferencesCubit.state,
    );
    final session$ = _userSessionCubit.stream.startWith(
      _userSessionCubit.state,
    );

    _subscription =
        Rx.combineLatest4(
              conferences$,
              session$,
              _selectedConfId$,
              _selectedTrack$,
              (
                ConferencesState conferences,
                UserSessionState session,
                String? selectedConfId,
                EventItemType selectedTrack,
              ) => (
                conferences: conferences,
                session: session,
                selectedConfId: selectedConfId,
                selectedTrack: selectedTrack,
              ),
            )
            .switchMap(_mapToState)
            .listen(
              (next) {
                if (isClosed) return;
                var merged = next;
                if (state.message != null) {
                  merged = merged.copyWith(message: state.message);
                }
                emit(merged);
              },
              onError: (Object error, StackTrace stackTrace) {
                if (isClosed) return;
                emit(state.copyWith(message: error.toString(), loading: false));
              },
            );
  }

  Stream<AdminState> _mapToState(
    ({
      ConferencesState conferences,
      UserSessionState session,
      String? selectedConfId,
      EventItemType selectedTrack,
    })
    snapshot,
  ) {
    if (!snapshot.session.isAdmin) {
      return Stream.value(const AdminState());
    }

    final loaded = snapshot.conferences.mapOrNull(loaded: (state) => state);
    if (loaded == null) {
      return Stream.value(const AdminState(isAdmin: true, loading: true));
    }

    final confIds = _sortedConfIds(
      loaded.conferences.list.map((conference) => conference.confId),
    );
    if (confIds.isEmpty) {
      return Stream.value(const AdminState(isAdmin: true));
    }

    final latestConfId = LatestConferenceResolver.fromConfIds(confIds);
    final selectedConfId = _resolveSelectedConfId(
      preferred: snapshot.selectedConfId,
      confIds: confIds,
      latestConfId: latestConfId,
    );
    final availableTracks = _tracksForConf(selectedConfId);
    final selectedTrack = availableTracks.contains(snapshot.selectedTrack)
        ? snapshot.selectedTrack
        : availableTracks.first;

    final ranking$ = Stream.fromFuture(
      _loadRanking(confId: selectedConfId, track: selectedTrack),
    ).startWith(const <EventVoteRank>[]);

    return Rx.combineLatest2(
      _configRepository.watchConfig(selectedConfId),
      ranking$,
      (EngagementConfig config, List<EventVoteRank> ranking) => AdminState(
        isAdmin: true,
        latestConfId: latestConfId,
        selectedConfId: selectedConfId,
        confIds: confIds,
        selectedTrack: selectedTrack,
        availableTracks: availableTracks,
        config: config,
        ranking: ranking,
      ),
    ).startWith(
      AdminState(
        isAdmin: true,
        loading: true,
        latestConfId: latestConfId,
        selectedConfId: selectedConfId,
        confIds: confIds,
        selectedTrack: selectedTrack,
        availableTracks: availableTracks,
      ),
    );
  }

  Future<List<EventVoteRank>> _loadRanking({
    required String confId,
    required EventItemType track,
  }) async {
    try {
      final counts = await _eventVoteRepository.loadVoteCounts(confId);
      final events = await _getAllEvents.call(
        Params(
          eventItemType: track.name,
          confId: confId,
          limit: 1000,
        ),
      );
      final ranking = [
        for (final event in events)
          if (event.speaker != null)
            EventVoteRank(
              eventId: event.id,
              title: event.title,
              speakerName: event.speaker?.name ?? '',
              trackType: event.type,
              likes: counts[event.id]?.likes ?? 0,
            ),
      ];
      return EventVoteRanking.sort(
        ranking.where((entry) => entry.likes > 0).toList(),
      );
    } catch (_) {
      return const [];
    }
  }

  Future<void> saveVoting({
    required bool enabled,
    required DateTime start,
    required DateTime end,
  }) async {
    final confId = state.selectedConfId;
    final config = state.config;
    if (confId == null || config == null) return;
    final trackConfig = config.forTrack(state.selectedTrack);
    await _configRepository.saveTrackConfig(
      confId: confId,
      track: state.selectedTrack,
      config: trackConfig.copyWith(
        votingEnabled: enabled,
        votingStartsAt: start.toUtc(),
        votingEndsAt: end.toUtc(),
      ),
    );
  }

  Future<void> saveTop5Enabled(bool enabled) async {
    final confId = state.selectedConfId;
    final config = state.config;
    if (confId == null || config == null) return;
    final trackConfig = config.forTrack(state.selectedTrack);
    await _configRepository.saveTrackConfig(
      confId: confId,
      track: state.selectedTrack,
      config: trackConfig.copyWith(top5Enabled: enabled),
    );
  }

  Future<void> endVotingNow() async {
    final confId = state.selectedConfId;
    final config = state.config;
    if (confId == null || config == null) return;
    final trackConfig = config.forTrack(state.selectedTrack);
    await _configRepository.saveTrackConfig(
      confId: confId,
      track: state.selectedTrack,
      config: trackConfig.copyWith(votingEndsAt: DateTime.now().toUtc()),
    );
  }

  void clearMessage() {
    if (!isClosed && state.message != null) {
      emit(state.copyWith(message: null));
    }
  }

  static List<String> _sortedConfIds(Iterable<String> confIds) {
    final unique = confIds.toSet().toList()
      ..sort((a, b) => b.compareTo(a));
    return unique;
  }

  static List<EventItemType> _tracksForConf(String confId) {
    final confIdInt = int.tryParse(confId) ?? 0;
    if (confIdInt >= 2025) return EventItemType.values;
    return const [EventItemType.ngPoland, EventItemType.jsPoland];
  }

  static String _resolveSelectedConfId({
    required String? preferred,
    required List<String> confIds,
    required String? latestConfId,
  }) {
    if (preferred != null && confIds.contains(preferred)) {
      return preferred;
    }
    if (latestConfId != null && confIds.contains(latestConfId)) {
      return latestConfId;
    }
    return confIds.first;
  }

  static AdminState _seedState(
    UserSessionCubit session,
    ConferencesCubit conferences,
  ) {
    if (!session.state.isAdmin) return const AdminState();
    final loaded = conferences.state.mapOrNull(loaded: (state) => state);
    final confIds = loaded == null
        ? const <String>[]
        : _sortedConfIds(
            loaded.conferences.list.map((conference) => conference.confId),
          );
    final latestConfId = confIds.isEmpty
        ? null
        : LatestConferenceResolver.fromConfIds(confIds);
    final selectedConfId = confIds.isEmpty
        ? null
        : _resolveSelectedConfId(
            preferred: null,
            confIds: confIds,
            latestConfId: latestConfId,
          );
    final availableTracks = selectedConfId == null
        ? const [EventItemType.ngPoland, EventItemType.jsPoland]
        : _tracksForConf(selectedConfId);
    return AdminState(
      isAdmin: true,
      loading: true,
      latestConfId: latestConfId,
      selectedConfId: selectedConfId,
      confIds: confIds,
      selectedTrack: availableTracks.first,
      availableTracks: availableTracks,
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    await _selectedConfId$.close();
    await _selectedTrack$.close();
    return super.close();
  }
}
