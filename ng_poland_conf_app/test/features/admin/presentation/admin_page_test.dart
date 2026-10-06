import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/admin_page.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';

void main() {
  testWidgets('shows voting hub card', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AdminHubContent(
            config: TrackEngagementConfig.missing,
            onVotingTap: () {},
          ),
        ),
      ),
    );

    expect(find.text('Voting'), findsOneWidget);
    expect(find.textContaining('Top 5'), findsOneWidget);
    expect(find.byType(AdminHubNavCard), findsOneWidget);
  });
}
