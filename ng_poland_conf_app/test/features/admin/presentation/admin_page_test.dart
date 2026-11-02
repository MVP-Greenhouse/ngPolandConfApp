import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/core/presentation/theme/app_palette.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/pages/admin_page.dart';

void main() {
  Future<void> pumpHub(
    WidgetTester tester, {
    VoidCallback? onVotingTap,
    VoidCallback? onSync,
  }) {
    return tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(extensions: const [AppPalette.light]),
        home: Scaffold(
          body: AdminHubContent(
            confId: '2026',
            onVotingTap: onVotingTap ?? () {},
            onSyncVotableEvents: onSync,
          ),
        ),
      ),
    );
  }

  testWidgets('groups voting settings and sync under Voting', (tester) async {
    await pumpHub(tester, onSync: () {});

    expect(find.text('Voting'), findsOneWidget);
    expect(find.text('Settings & ranking'), findsOneWidget);
    expect(find.text('Sync votable events'), findsOneWidget);
    expect(find.textContaining('conference 2026'), findsOneWidget);
    expect(find.text('enabled'), findsNothing);
    expect(find.textContaining('Top 5:'), findsNothing);
  });

  testWidgets('settings row opens voting settings', (tester) async {
    var taps = 0;
    await pumpHub(tester, onVotingTap: () => taps++);

    await tester.tap(find.byType(AdminHubNavRow));
    expect(taps, 1);
  });

  testWidgets('sync button triggers sync', (tester) async {
    var syncs = 0;
    await pumpHub(tester, onSync: () => syncs++);

    await tester.tap(find.text('Sync votable events'));
    expect(syncs, 1);
  });
}
