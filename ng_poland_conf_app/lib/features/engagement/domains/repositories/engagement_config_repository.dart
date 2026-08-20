import '../entities/engagement_config.dart';

abstract interface class EngagementConfigRepository {
  Stream<EngagementConfig> watchConfig(String confId);

  Future<void> saveConfig(String confId, EngagementConfig config);
}
