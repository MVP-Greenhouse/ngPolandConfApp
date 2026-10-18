import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/domain/use_case.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_session.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/repositories/user_session_repository.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/entities/event_vote_status.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/repositories/event_vote_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/repositories/votable_event_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/usecases/watch_track_engagement.dart';
import 'package:rxdart/rxdart.dart';

/// Vote button state of a single talk.
///
/// A talk is votable while voting is open for its track and only once the
/// talk has ended; the stream switches on by itself at that moment.
@injectable
class WatchEventVote
    implements StreamUseCase<EventVoteStatus, WatchEventVoteParams> {
  const WatchEventVote(
    this._watchTrackEngagement,
    this._sessions,
    this._votableEvents,
    this._votes,
  );

  final WatchTrackEngagement _watchTrackEngagement;
  final UserSessionRepository _sessions;
  final VotableEventRepository _votableEvents;
  final EventVoteRepository _votes;

  @override
  Stream<EventVoteStatus> call(WatchEventVoteParams params) =>
      _watchTrackEngagement(params.track).switchMap((engagement) {
        if (!engagement.votingOpen) {
          return Stream.value(const EventVoteHidden());
        }
        final confId = engagement.confId;
        return _votableEvents
            .watchEvent(confId: confId, eventId: params.eventId)
            .switchMap(
              (event) => _afterEnd(
                event?.endsAt,
                () => _sessions.watch().switchMap(
                  (session) => switch (session) {
                    SessionLoading() => Stream.value(const EventVoteHidden()),
                    SignedOut() => Stream.value(const EventVoteNeedsLogin()),
                    SignedIn(:final profile) =>
                      _votes
                          .watchMyLike(
                            confId: confId,
                            eventId: params.eventId,
                            uid: profile.uid,
                          )
                          .map<EventVoteStatus>(
                            (liked) => EventVoteAvailable(liked: liked),
                          )
                          .startWith(const EventVoteHidden()),
                  },
                ),
              ),
            );
      });

  static Stream<EventVoteStatus> _afterEnd(
    DateTime? endsAt,
    Stream<EventVoteStatus> Function() next,
  ) {
    if (endsAt == null) return Stream.value(const EventVoteHidden());
    final wait = endsAt.toUtc().difference(DateTime.now().toUtc());
    if (wait <= Duration.zero) return next();
    return Rx.concat([
      Stream.value(const EventVoteHidden()),
      Rx.timer<void>(null, wait).asyncExpand((_) => next()),
    ]);
  }
}

class WatchEventVoteParams {
  const WatchEventVoteParams({required this.eventId, required this.track});

  final String eventId;
  final EventItemType track;
}
