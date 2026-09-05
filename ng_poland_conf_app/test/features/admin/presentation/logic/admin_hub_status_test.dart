import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/logic/admin_hub_status.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_status.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';

void main() {
  final base = EngagementConfig(
    votingEnabled: true,
    votingStartsAt: DateTime.utc(2026, 1, 1),
    votingEndsAt: DateTime.utc(2026, 1, 2),
    contestEnabled: true,
    contestStartsAt: DateTime.utc(2026, 1, 1),
    contestEndsAt: DateTime.utc(2026, 1, 2),
    contestStatus: ContestStatus.open,
  );

  test('voting subtitle on/off', () {
    expect(AdminHubStatus.votingSubtitle(base), 'włączone');
    expect(
      AdminHubStatus.votingSubtitle(base.copyWith(votingEnabled: false)),
      'wyłączone',
    );
  });

  test('contest subtitle format', () {
    expect(
      AdminHubStatus.contestSubtitle(config: base, participantCount: 12),
      'włączone · open · 12 zgłoszeń',
    );
    expect(
      AdminHubStatus.contestSubtitle(
        config: base.copyWith(
          contestEnabled: false,
          contestStatus: ContestStatus.finished,
        ),
        participantCount: 0,
      ),
      'wyłączone · finished · 0 zgłoszeń',
    );
  });
}
