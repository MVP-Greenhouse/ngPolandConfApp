import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:ng_poland_conf_app/core/domain/app_exception.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/app_notice.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/admin_notices.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_session.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/watch_user_session.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/conference.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/edition/domain/exceptions/edition_unavailable_exception.dart';
import 'package:ng_poland_conf_app/features/edition/domain/services/conference_tracks.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/exceptions/engagement_exception.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/services/event_vote_ranking.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/services/votable_event_catalog.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/usecases/load_vote_ranking.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/usecases/sync_votable_events.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/usecases/update_track_engagement_config.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/usecases/watch_engagement_config.dart';
import 'package:ng_poland_conf_app/features/home/domain/usecases/watch_current_conference.dart';
import 'package:rxdart/rxdart.dart';

part 'admin_state.dart';

@injectable
class AdminCubit extends Cubit<AdminState> {
  AdminCubit(
    WatchUserSession watchUserSession,
    WatchCurrentConference watchCurrentConference,
    this._watchEngagementConfig,
    this._loadVoteRanking,
    this._updateTrackConfig,
    this._syncVotableEvents,
    this._logger,
  ) : super(const AdminState()) {
    _subscription =
        Rx.combineLatest3(
              watchUserSession(),
              watchCurrentConference(),
              _selectedTrack$,
              (
                UserSession session,
                Conference conference,
                EventItemType track,
              ) => (session: session, conference: conference, track: track),
            )
            .switchMap(_mapToState)
            .listen(
              (next) => emit(next.copyWith(notice: state.notice)),
              onError: (Object error, StackTrace stackTrace) {
                _logger.w(
                  'Admin: dashboard failed',
                  error: error,
                  stackTrace: stackTrace,
                );
                emit(state.copyWith(loading: false));
              },
            );
  }

  final WatchEngagementConfig _watchEngagementConfig;
  final LoadVoteRanking _loadVoteRanking;
  final UpdateTrackEngagementConfig _updateTrackConfig;
  final SyncVotableEvents _syncVotableEvents;
  final Logger _logger;

  final _selectedTrack$ = BehaviorSubject<EventItemType>.seeded(.ngPoland);
  late final StreamSubscription<AdminState> _subscription;
  bool _syncingVotableEvents = false;

  void selectTrack(EventItemType track) {
    if (_selectedTrack$.value != track) _selectedTrack$.add(track);
  }

  Stream<AdminState> _mapToState(
    ({UserSession session, Conference conference, EventItemType track}) input,
  ) {
    if (!input.session.isAdmin) return Stream.value(const AdminState());

    final confId = input.conference.confId;
    final tracks = tracksForConference(confId);
    final track = tracks.contains(input.track)
        ? input.track
        : tracks.firstOrNull ?? EventItemType.ngPoland;
    final base = AdminState(
      isAdmin: true,
      loading: true,
      selectedConfId: confId,
      selectedTrack: track,
      availableTracks: tracks,
    );

    return Rx.combineLatest2(
      _watchEngagementConfig(confId),
      Stream.fromFuture(_ranking(confId, track)).startWith(const []),
      (EngagementConfig config, List<EventVoteRank> ranking) =>
          base.copyWith(loading: false, config: config, ranking: ranking),
    ).startWith(base);
  }

  Future<List<EventVoteRank>> _ranking(
    String confId,
    EventItemType track,
  ) async {
    try {
      return await _loadVoteRanking(
        LoadVoteRankingParams(confId: confId, track: track),
      );
    } on AppException catch (error, stackTrace) {
      _logger.w(
        'Admin: ranking unavailable',
        error: error,
        stackTrace: stackTrace,
      );
      return const [];
    }
  }

  Future<void> saveVoting({
    required bool enabled,
    required DateTime start,
    required DateTime end,
  }) => _saveTrack(
    (config) => config.copyWith(
      votingEnabled: enabled,
      votingStartsAt: start.toUtc(),
      votingEndsAt: end.toUtc(),
    ),
  );

  Future<void> saveTop5Enabled(bool enabled) =>
      _saveTrack((config) => config.copyWith(top5Enabled: enabled));

  Future<void> endVotingNow() => _saveTrack(
    (config) => config.copyWith(votingEndsAt: DateTime.now().toUtc()),
  );

  Future<void> _saveTrack(
    TrackEngagementConfig Function(TrackEngagementConfig) update,
  ) async {
    final confId = state.selectedConfId;
    final config = state.config;
    if (confId == null || config == null) return;
    final track = state.selectedTrack;
    try {
      await _updateTrackConfig(
        UpdateTrackEngagementConfigParams(
          confId: confId,
          track: track,
          config: update(config.forTrack(track)),
        ),
      );
    } on EngagementException catch (error, stackTrace) {
      _logger.w(
        'Admin: saving config failed',
        error: error,
        stackTrace: stackTrace,
      );
      _showNotice(AdminNotices.saveFailed(error.message));
    }
  }

  Future<void> syncVotableEvents() async {
    final confId = state.selectedConfId;
    if (confId == null || _syncingVotableEvents) return;
    _syncingVotableEvents = true;
    try {
      final catalog = await _syncVotableEvents(confId);
      _showNotice(AdminNotices.synced(votableSyncMessage(catalog)));
    } on EditionUnavailableException catch (error, stackTrace) {
      _logger.w(
        'Admin: agenda refresh failed',
        error: error,
        stackTrace: stackTrace,
      );
      _showNotice(AdminNotices.syncFailed);
    } on EngagementException catch (error, stackTrace) {
      _logger.w(
        'Admin: votable sync rejected',
        error: error,
        stackTrace: stackTrace,
      );
      _showNotice(AdminNotices.syncRejected(error.message));
    } finally {
      _syncingVotableEvents = false;
    }
  }

  void clearNotice() {
    if (!isClosed && state.notice != null) emit(state.copyWith(notice: null));
  }

  void _showNotice(AppNotice notice) {
    if (!isClosed) emit(state.copyWith(notice: notice));
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    await _selectedTrack$.close();
    return super.close();
  }
}
