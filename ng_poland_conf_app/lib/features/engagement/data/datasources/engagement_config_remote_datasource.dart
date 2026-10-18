import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/engagement/data/mappers/engagement_mappers.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/entities/engagement_config.dart';

@injectable
class EngagementConfigRemoteDataSource {
  EngagementConfigRemoteDataSource({@ignoreParam FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  DocumentReference<Map<String, dynamic>> _configRef(String confId) =>
      _firestore
          .collection('conf')
          .doc(confId)
          .collection('engagement')
          .doc('config');

  Stream<EngagementConfig> watchConfig(String confId) {
    return _configRef(
      confId,
    ).snapshots().map((snap) => EngagementMappers.configFromMap(snap.data()));
  }

  Future<void> saveTrackConfig({
    required String confId,
    required EventItemType track,
    required TrackEngagementConfig config,
  }) {
    return _configRef(confId).set({
      'tracks': {
        track.name: _datesToTimestamp(EngagementMappers.trackToMap(config)),
      },
    }, SetOptions(merge: true));
  }

  Map<String, dynamic> _datesToTimestamp(Map<String, dynamic> data) {
    return data.map((key, value) {
      if (value is DateTime) {
        return MapEntry(key, Timestamp.fromDate(value));
      }
      return MapEntry(key, value);
    });
  }
}
