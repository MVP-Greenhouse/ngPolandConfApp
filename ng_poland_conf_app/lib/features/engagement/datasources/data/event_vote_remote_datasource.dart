import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/engagement/datasources/data/engagement_mappers.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/event_vote_counts.dart';

@injectable
class EventVoteRemoteDataSource {
  EventVoteRemoteDataSource({@ignoreParam FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  DocumentReference<Map<String, dynamic>> _voteRef({
    required String confId,
    required String eventId,
    required String uid,
  }) => _firestore
      .collection('conf')
      .doc(confId)
      .collection('eventVotes')
      .doc(eventId)
      .collection('votes')
      .doc(uid);

  Stream<bool> watchMyLike({
    required String confId,
    required String eventId,
    required String uid,
  }) {
    return _voteRef(
      confId: confId,
      eventId: eventId,
      uid: uid,
    ).snapshots().map((snap) => EngagementMappers.isLikeFromMap(snap.data()));
  }

  Future<void> setLike({
    required String confId,
    required String eventId,
    required String uid,
    required bool liked,
  }) async {
    final parent = _firestore
        .collection('conf')
        .doc(confId)
        .collection('eventVotes')
        .doc(eventId);
    final vote = parent.collection('votes').doc(uid);

    await _firestore.runTransaction((transaction) async {
      final parentSnap = await transaction.get(parent);
      final voteSnap = await transaction.get(vote);
      final likes = (parentSnap.data()?['likes'] as num?)?.toInt() ?? 0;
      if (!liked) {
        if (!voteSnap.exists) return;
        transaction.set(parent, {
          'likes': likes > 0 ? likes - 1 : 0,
        }, SetOptions(merge: true));
        transaction.delete(vote);
        return;
      }
      if (voteSnap.exists) return;
      transaction.set(parent, {'likes': likes + 1}, SetOptions(merge: true));
      transaction.set(vote, {
        'value': 1,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });
  }

  Future<Map<String, EventVoteCounts>> loadVoteCounts(String confId) async {
    final eventsSnap = await _firestore
        .collection('conf')
        .doc(confId)
        .collection('eventVotes')
        .get();

    final counts = <String, EventVoteCounts>{};
    for (final eventDoc in eventsSnap.docs) {
      final likes = (eventDoc.data()['likes'] as num?)?.toInt() ?? 0;
      if (likes > 0) {
        counts[eventDoc.id] = EventVoteCounts(likes: likes);
      }
    }
    return counts;
  }
}
