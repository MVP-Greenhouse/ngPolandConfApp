import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_status.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';

class AdminHubStatus {
  const AdminHubStatus._();

  static String enabledLabel(bool enabled) =>
      enabled ? 'włączone' : 'wyłączone';

  static String votingSubtitle(EngagementConfig config) =>
      enabledLabel(config.votingEnabled);

  static String contestStatusLabel(ContestStatus status) => status.name;

  static String participantChipLabel(int participantCount) =>
      '$participantCount zgł.';

  static String contestSubtitle({
    required EngagementConfig config,
    required int participantCount,
  }) {
    return '${enabledLabel(config.contestEnabled)}'
        ' · ${contestStatusLabel(config.contestStatus)}'
        ' · ${participantChipLabel(participantCount)}';
  }
}
