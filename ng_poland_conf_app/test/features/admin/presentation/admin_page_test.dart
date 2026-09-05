import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/admin_page.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';

void main() {
  testWidgets('shows voting and contest destinations', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AdminHubContent(
            config: EngagementConfig.missing,
            participantCount: 3,
            onVotingTap: () {},
            onContestTap: () {},
          ),
        ),
      ),
    );

    expect(find.text('Głosowanie'), findsOneWidget);
    expect(find.text('Konkurs'), findsOneWidget);
    expect(find.textContaining('3 zgłoszeń'), findsOneWidget);
  });
}
