import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/engagement/datasources/data/engagement_mappers.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';

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
    return _configRef(confId).snapshots().map(
      (snap) => EngagementMappers.configFromMap(_datesToDateTime(snap.data())),
    );
  }

  Future<void> saveConfig(String confId, EngagementConfig config) {
    return _configRef(
      confId,
    ).set(_datesToTimestamp(EngagementMappers.configToMap(config)));
  }

  Map<String, dynamic>? _datesToDateTime(Map<String, dynamic>? data) {
    if (data == null) return null;
    return data.map((key, value) {
      if (value is Timestamp) {
        return MapEntry(
          key,
          DateTime.fromMillisecondsSinceEpoch(
            value.millisecondsSinceEpoch,
            isUtc: true,
          ),
        );
      }
      return MapEntry(key, value);
    });
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
