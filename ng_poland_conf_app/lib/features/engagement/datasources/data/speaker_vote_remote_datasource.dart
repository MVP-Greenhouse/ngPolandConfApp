import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/engagement/datasources/data/engagement_mappers.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/speaker_vote_counts.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/speaker_vote_value.dart';

@injectable
class SpeakerVoteRemoteDataSource {
  SpeakerVoteRemoteDataSource({@ignoreParam FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  DocumentReference<Map<String, dynamic>> _voteRef({
    required String confId,
    required String speakerId,
    required String uid,
  }) => _firestore
      .collection('conf')
      .doc(confId)
      .collection('speakerVotes')
      .doc(speakerId)
      .collection('votes')
      .doc(uid);

  CollectionReference<Map<String, dynamic>> _votesCollection({
    required String confId,
    required String speakerId,
  }) => _firestore
      .collection('conf')
      .doc(confId)
      .collection('speakerVotes')
      .doc(speakerId)
      .collection('votes');

  Stream<SpeakerVoteValue?> watchMyVote({
    required String confId,
    required String speakerId,
    required String uid,
  }) {
    return _voteRef(
      confId: confId,
      speakerId: speakerId,
      uid: uid,
    ).snapshots().map((snap) => EngagementMappers.voteFromMap(snap.data()));
  }

  Future<void> setVote({
    required String confId,
    required String speakerId,
    required String uid,
    SpeakerVoteValue? value,
  }) async {
    final ref = _voteRef(confId: confId, speakerId: speakerId, uid: uid);
    if (value == null) {
      await ref.delete();
      return;
    }
    await _firestore
        .collection('conf')
        .doc(confId)
        .collection('speakerVotes')
        .doc(speakerId)
        .set({}, SetOptions(merge: true));
    await ref.set({
      'value': value.firestoreValue,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<Map<String, SpeakerVoteValue>> watchAllVotes({
    required String confId,
    required String speakerId,
  }) {
    return _votesCollection(
      confId: confId,
      speakerId: speakerId,
    ).snapshots().map((snap) {
      final votes = <String, SpeakerVoteValue>{};
      for (final doc in snap.docs) {
        final value = EngagementMappers.voteFromMap(doc.data());
        if (value != null) {
          votes[doc.id] = value;
        }
      }
      return votes;
    });
  }

  Future<Map<String, SpeakerVoteCounts>> loadVoteCounts(String confId) async {
    final speakersSnap = await _firestore
        .collection('conf')
        .doc(confId)
        .collection('speakerVotes')
        .get();
    final counts = <String, SpeakerVoteCounts>{};
    for (final speakerDoc in speakersSnap.docs) {
      final votesSnap = await speakerDoc.reference.collection('votes').get();
      var up = 0;
      var down = 0;
      for (final voteDoc in votesSnap.docs) {
        final value = EngagementMappers.voteFromMap(voteDoc.data());
        if (value == SpeakerVoteValue.up) {
          up++;
        } else if (value == SpeakerVoteValue.down) {
          down++;
        }
      }
      counts[speakerDoc.id] = SpeakerVoteCounts(up: up, down: down);
    }
    return counts;
  }
}
