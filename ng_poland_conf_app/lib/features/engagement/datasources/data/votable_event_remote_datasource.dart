import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/votable_event.dart';

@injectable
class VotableEventRemoteDataSource {
  VotableEventRemoteDataSource({@ignoreParam FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _collection(String confId) =>
      _firestore.collection('conf').doc(confId).collection('votableEvents');

  Stream<VotableEvent?> watchEvent({
    required String confId,
    required String eventId,
  }) {
    return _collection(confId).doc(eventId).snapshots().map((snap) {
      final data = snap.data();
      if (data == null) return null;
      return votableEventFromMap(eventId, data);
    });
  }

  Future<Map<String, VotableEvent>> loadEvents(String confId) async {
    final snap = await _collection(confId).get();
    final events = [
      for (final doc in snap.docs) ?votableEventFromMap(doc.id, doc.data()),
    ];
    return {for (final event in events) event.eventId: event};
  }

  Future<void> replaceCatalog({
    required String confId,
    required List<VotableEvent> events,
  }) async {
    final collection = _collection(confId);
    final existing = await collection.get();
    final nextIds = {for (final event in events) event.eventId};
    final batch = _firestore.batch();
    var operations = 0;

    for (final doc in existing.docs) {
      if (!nextIds.contains(doc.id)) {
        batch.delete(doc.reference);
        operations++;
      }
    }
    for (final event in events) {
      batch.set(collection.doc(event.eventId), {
        'endsAt': Timestamp.fromDate(event.endsAt.toUtc()),
        'track': event.track.name,
      });
      operations++;
    }
    if (operations == 0) return;
    await batch.commit();
  }
}

VotableEvent? votableEventFromMap(String eventId, Map<String, dynamic> data) {
  final endsAt = data['endsAt'];
  final trackName = data['track'];
  if (endsAt is! Timestamp || trackName is! String) return null;
  final track = EventItemType.values.where((type) => type.name == trackName);
  if (track.isEmpty) return null;
  return VotableEvent(
    eventId: eventId,
    endsAt: endsAt.toDate().toUtc(),
    track: track.first,
  );
}
