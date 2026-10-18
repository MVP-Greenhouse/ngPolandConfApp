import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/domain/use_case.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/repositories/user_session_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/exceptions/engagement_exception.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/repositories/event_vote_repository.dart';
import 'package:ng_poland_conf_app/features/home/domain/repositories/conference_repository.dart';

/// Adds or removes the signed-in user's vote for a talk.
@injectable
class CastEventVote implements UseCase<void, CastEventVoteParams> {
  const CastEventVote(this._sessions, this._conferences, this._votes);

  final UserSessionRepository _sessions;
  final ConferenceRepository _conferences;
  final EventVoteRepository _votes;

  @override
  Future<void> call(CastEventVoteParams params) {
    final uid = _sessions.current.profile?.uid;
    if (uid == null) throw const VoteRejectedException('Sign in to vote.');
    final confId = _conferences.current?.confId;
    if (confId == null) {
      throw const VoteRejectedException('Conference data is not loaded yet.');
    }
    return _votes.setLike(
      confId: confId,
      eventId: params.eventId,
      uid: uid,
      liked: params.liked,
    );
  }
}

class CastEventVoteParams {
  const CastEventVoteParams({required this.eventId, required this.liked});

  final String eventId;
  final bool liked;
}
