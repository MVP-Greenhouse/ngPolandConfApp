import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/theme/app_palette.dart';
import 'package:ng_poland_conf_app/widgets/app_notice.dart';

void main() {
  test('admin sync message becomes a voting-list notice', () {
    final notice = AppNotice.fromAdminMessage('Synced 12 votable events');

    expect(notice.title, 'Voting list updated');
    expect(notice.body, 'Synced 12 votable events');
    expect(notice.tone, AppNoticeTone.success);
  });

  testWidgets('notice uses the app card instead of a plain snackbar', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          extensions: const [AppPalette.dark],
        ),
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return TextButton(
                onPressed: () =>
                    showAppNotice(context, AppNotice.voteUnavailable),
                child: const Text('Show'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Show'));
    await tester.pump();

    expect(find.text("This talk can't be voted on"), findsOneWidget);
    expect(find.byType(AppNoticeCard), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);

    final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
    expect(snackBar.backgroundColor, Colors.transparent);
    expect(snackBar.elevation, 0);
  });
}
