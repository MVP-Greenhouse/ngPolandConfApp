import 'package:ng_poland_conf_app/features/engagement/domains/entities/event_vote_counts.dart';

abstract class EventVoteRepository {
  Stream<bool> watchMyLike({
    required String confId,
    required String eventId,
    required String uid,
  });

  Future<void> setLike({
    required String confId,
    required String eventId,
    required String uid,
    required bool liked,
  });

  Future<Map<String, EventVoteCounts>> loadVoteCounts(String confId);
}
