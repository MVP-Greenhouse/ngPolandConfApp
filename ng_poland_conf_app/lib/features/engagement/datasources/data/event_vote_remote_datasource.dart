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
    final ref = _voteRef(confId: confId, eventId: eventId, uid: uid);
    if (!liked) {
      await ref.delete();
      return;
    }
    await _firestore
        .collection('conf')
        .doc(confId)
        .collection('eventVotes')
        .doc(eventId)
        .set({}, SetOptions(merge: true));
    await ref.set({
      'value': 1,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<Map<String, EventVoteCounts>> loadVoteCounts(String confId) async {
    final eventsSnap = await _firestore
        .collection('conf')
        .doc(confId)
        .collection('eventVotes')
        .get();

    final counts = <String, EventVoteCounts>{};
    await Future.wait(
      eventsSnap.docs.map((eventDoc) async {
        final votesSnap = await eventDoc.reference.collection('votes').get();
        var likes = 0;
        for (final voteDoc in votesSnap.docs) {
          if (EngagementMappers.isLikeFromMap(voteDoc.data())) {
            likes++;
          }
        }
        if (likes > 0) {
          counts[eventDoc.id] = EventVoteCounts(likes: likes);
        }
      }),
    );
    return counts;
  }
}
