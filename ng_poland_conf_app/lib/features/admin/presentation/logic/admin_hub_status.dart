import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';

class AdminHubStatus {
  const AdminHubStatus._();

  static String enabledLabel(bool enabled) =>
      enabled ? 'enabled' : 'disabled';

  static String votingSubtitle(TrackEngagementConfig config) =>
      enabledLabel(config.votingEnabled);

  static String top5Subtitle(TrackEngagementConfig config) =>
      enabledLabel(config.top5Enabled);
}
