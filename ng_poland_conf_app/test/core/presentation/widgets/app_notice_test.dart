import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/core/presentation/theme/app_palette.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/app_notice.dart';

void main() {
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

  testWidgets('an error notice stands out on a solid error background', (
    tester,
  ) async {
    final theme = ThemeData(
      brightness: Brightness.dark,
      extensions: const [AppPalette.dark],
    );
    await tester.pumpWidget(
      MaterialApp(
        theme: theme,
        home: const Scaffold(
          body: AppNoticeCard(
            notice: AppNotice(
              title: 'It failed',
              body: 'Try again.',
              tone: AppNoticeTone.error,
            ),
          ),
        ),
      ),
    );

    final card = tester.widget<DecoratedBox>(
      find
          .descendant(
            of: find.byType(AppNoticeCard),
            matching: find.byType(DecoratedBox),
          )
          .first,
    );
    expect((card.decoration as BoxDecoration).color, theme.colorScheme.error);
    expect(
      tester.widget<Text>(find.text('It failed')).style?.color,
      AppPalette.dark.onAccent,
    );
    expect(
      tester.widget<Text>(find.text('Try again.')).style?.color,
      AppPalette.dark.onAccent,
    );
  });
}
