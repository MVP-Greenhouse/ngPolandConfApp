import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import '../entities/engagement_config.dart';

abstract interface class EngagementConfigRepository {
  Stream<EngagementConfig> watchConfig(String confId);

  Future<void> saveTrackConfig({
    required String confId,
    required EventItemType track,
    required TrackEngagementConfig config,
  });
}
