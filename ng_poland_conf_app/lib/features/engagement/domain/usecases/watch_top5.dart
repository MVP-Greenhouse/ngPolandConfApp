import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:ng_poland_conf_app/core/domain/app_exception.dart';
import 'package:ng_poland_conf_app/core/domain/use_case.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/repositories/user_session_repository.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/entities/top5_board.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/entities/track_engagement.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/repositories/event_vote_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/services/event_vote_ranking.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/usecases/load_vote_ranking.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/usecases/watch_track_engagement.dart';
import 'package:rxdart/rxdart.dart';

/// Live Top 5 of a track, including the signed-in user's own votes.
@injectable
class WatchTop5 implements StreamUseCase<Top5Status, EventItemType> {
  const WatchTop5(
    this._watchTrackEngagement,
    this._loadVoteRanking,
    this._sessions,
    this._votes,
    this._logger,
  );

  /// Size of the public ranking.
  static const boardSize = 5;

  final WatchTrackEngagement _watchTrackEngagement;
  final LoadVoteRanking _loadVoteRanking;
  final UserSessionRepository _sessions;
  final EventVoteRepository _votes;
  final Logger _logger;

  @override
  Stream<Top5Status> call(EventItemType track) =>
      _watchTrackEngagement(track).switchMap((engagement) {
        if (!engagement.top5Enabled) return Stream.value(const Top5Hidden());
        return _sessions
            .watch()
            .map((session) => session.profile?.uid)
            .distinct()
            .switchMap(
              (uid) => Stream.fromFuture(_loadTop(engagement))
                  .switchMap<Top5Status>(
                    (top) => _watchMyVotes(engagement.confId, uid, top).map(
                      (myVotes) => Top5Board(
                        confId: engagement.confId,
                        track: track,
                        votingOpen: engagement.votingOpen,
                        top: top,
                        myVotes: myVotes,
                      ),
                    ),
                  )
                  .startWith(const Top5Loading()),
            );
      });

  /// A failed load shows an empty board until the next config or session
  /// change triggers a reload.
  Future<List<EventVoteRank>> _loadTop(TrackEngagement engagement) async {
    try {
      final ranking = await _loadVoteRanking(
        LoadVoteRankingParams(
          confId: engagement.confId,
          track: engagement.track,
        ),
      );
      return ranking.take(boardSize).toList();
    } on AppException catch (error, stackTrace) {
      _logger.w(
        'Top 5: ranking unavailable',
        error: error,
        stackTrace: stackTrace,
      );
      return const [];
    }
  }

  Stream<Set<String>> _watchMyVotes(
    String confId,
    String? uid,
    List<EventVoteRank> top,
  ) {
    if (uid == null || top.isEmpty) return Stream.value(const {});
    return Rx.combineLatestList([
      for (final entry in top)
        _votes
            .watchMyLike(confId: confId, eventId: entry.eventId, uid: uid)
            .map((liked) => liked ? entry.eventId : null),
    ]).map((ids) => {...ids.nonNulls});
  }
}
