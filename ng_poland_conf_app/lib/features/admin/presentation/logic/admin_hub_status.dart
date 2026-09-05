import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';

class AdminHubStatus {
  const AdminHubStatus._();

  static String votingSubtitle(EngagementConfig config) =>
      config.votingEnabled ? 'włączone' : 'wyłączone';

  static String contestSubtitle({
    required EngagementConfig config,
    required int participantCount,
  }) {
    final enabled = config.contestEnabled ? 'włączone' : 'wyłączone';
    return '$enabled · ${config.contestStatus.name} · $participantCount zgłoszeń';
  }
}
