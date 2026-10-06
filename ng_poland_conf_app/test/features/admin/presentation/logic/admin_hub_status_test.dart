import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/logic/admin_hub_status.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';

void main() {
  final base = TrackEngagementConfig(
    votingEnabled: true,
    votingStartsAt: DateTime.utc(2026, 1, 1),
    votingEndsAt: DateTime.utc(2026, 1, 2),
    top5Enabled: true,
  );

  test('voting subtitle on/off', () {
    expect(AdminHubStatus.votingSubtitle(base), 'enabled');
    expect(
      AdminHubStatus.votingSubtitle(base.copyWith(votingEnabled: false)),
      'disabled',
    );
  });

  test('top5 subtitle on/off', () {
    expect(AdminHubStatus.top5Subtitle(base), 'enabled');
    expect(
      AdminHubStatus.top5Subtitle(base.copyWith(top5Enabled: false)),
      'disabled',
    );
  });
}
