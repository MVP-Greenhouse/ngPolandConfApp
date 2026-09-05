import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/engagement/datasources/data/engagement_mappers.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_history_entry.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_participant.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_status.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_winner.dart';

@injectable
class ContestRemoteDataSource {
  ContestRemoteDataSource({@ignoreParam FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  DocumentReference<Map<String, dynamic>> _participantRef({
    required String confId,
    required String uid,
  }) => _firestore
      .collection('conf')
      .doc(confId)
      .collection('contestParticipants')
      .doc(uid);

  CollectionReference<Map<String, dynamic>> _participantsCollection(
    String confId,
  ) => _firestore
      .collection('conf')
      .doc(confId)
      .collection('contestParticipants');

  DocumentReference<Map<String, dynamic>> _winnerRef({
    required String confId,
    required String uid,
  }) => _firestore
      .collection('conf')
      .doc(confId)
      .collection('contestWinners')
      .doc(uid);

  CollectionReference<Map<String, dynamic>> _winnersCollection(String confId) =>
      _firestore.collection('conf').doc(confId).collection('contestWinners');

  CollectionReference<Map<String, dynamic>> _historyCollection(String confId) =>
      _firestore.collection('conf').doc(confId).collection('contestHistory');

  DocumentReference<Map<String, dynamic>> _configRef(String confId) =>
      _firestore
          .collection('conf')
          .doc(confId)
          .collection('engagement')
          .doc('config');

  Stream<ContestParticipant?> watchMyParticipation({
    required String confId,
    required String uid,
  }) {
    return _participantRef(confId: confId, uid: uid).snapshots().map(
      (snap) => EngagementMappers.participantFromMap(uid, snap.data()),
    );
  }

  Future<void> join({
    required String confId,
    required String uid,
    required String displayName,
    required String email,
  }) {
    return _participantRef(confId: confId, uid: uid).set({
      'displayName': displayName,
      'email': email,
      'joinedAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<ContestParticipant>> watchParticipants(String confId) {
    return _participantsCollection(confId).snapshots().map((snap) {
      final participants = <ContestParticipant>[];
      for (final doc in snap.docs) {
        final participant = EngagementMappers.participantFromMap(
          doc.id,
          doc.data(),
        );
        if (participant != null) {
          participants.add(participant);
        }
      }
      return participants;
    });
  }

  Stream<ContestWinner?> watchMyWin({
    required String confId,
    required String uid,
  }) {
    return _winnerRef(confId: confId, uid: uid).snapshots().map(
      (snap) => EngagementMappers.winnerFromMap(uid, snap.data()),
    );
  }

  Stream<List<ContestWinner>> watchWinners(String confId) {
    return _winnersCollection(confId).snapshots().map((snap) {
      final winners = <ContestWinner>[];
      for (final doc in snap.docs) {
        final winner = EngagementMappers.winnerFromMap(doc.id, doc.data());
        if (winner != null) {
          winners.add(winner);
        }
      }
      winners.sort((a, b) => a.order.compareTo(b.order));
      return winners;
    });
  }

  Future<void> saveWinners({
    required String confId,
    required List<ContestWinner> winners,
  }) async {
    for (final winner in winners) {
      await _winnerRef(confId: confId, uid: winner.uid).set({
        'displayName': winner.displayName,
        'email': winner.email,
        'drawnAt': FieldValue.serverTimestamp(),
        'order': winner.order,
      });
    }
  }

  Future<void> updateContestStatus({
    required String confId,
    required ContestStatus status,
  }) {
    return _configRef(
      confId,
    ).set({'contestStatus': status.id}, SetOptions(merge: true));
  }

  Stream<List<ContestHistoryEntry>> watchHistory(String confId) {
    return _historyCollection(confId).snapshots().map((snapshot) {
      final history = <ContestHistoryEntry>[];
      for (final doc in snapshot.docs) {
        final entry = EngagementMappers.historyFromMap(doc.id, doc.data());
        if (entry != null) history.add(entry);
      }
      history.sort((a, b) => b.finishedAt.compareTo(a.finishedAt));
      return history;
    });
  }

  Future<void> archiveContestIfAbsent({
    required String confId,
    required ContestHistoryEntry entry,
  }) async {
    final ref = _historyCollection(confId).doc(entry.contestId);
    if ((await ref.get()).exists) return;
    await ref.set(EngagementMappers.historyToMap(entry));
  }

  Future<void> clearWinners(String confId) {
    return _clearCollection(_winnersCollection(confId));
  }

  Future<void> clearParticipants(String confId) {
    return _clearCollection(_participantsCollection(confId));
  }

  Future<void> _clearCollection(
    CollectionReference<Map<String, dynamic>> collection,
  ) async {
    final snapshot = await collection.get();
    const batchSize = 400;
    for (var offset = 0; offset < snapshot.docs.length; offset += batchSize) {
      final batch = _firestore.batch();
      for (final doc in snapshot.docs.skip(offset).take(batchSize)) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    }
  }
}
