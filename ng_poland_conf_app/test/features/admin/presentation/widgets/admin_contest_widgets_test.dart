import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/widgets/admin_contest_history_section.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/widgets/start_new_contest_dialog.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_history_entry.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_winner.dart';

void main() {
  testWidgets('history starts collapsed and shows archived winners', (
    tester,
  ) async {
    final entry = ContestHistoryEntry(
      contestId: 'contest-1',
      name: 'Jesienny konkurs',
      startsAt: DateTime.utc(2026, 9, 1),
      endsAt: DateTime.utc(2026, 9, 2),
      finishedAt: DateTime.utc(2026, 9, 2),
      winners: const [
        ContestWinner(
          uid: 'winner-1',
          displayName: 'Ada',
          email: 'ada@example.com',
          order: 1,
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: AdminContestHistorySection(history: [entry])),
      ),
    );

    expect(find.text('Historia'), findsOneWidget);
    expect(find.text('Jesienny konkurs'), findsNothing);

    await tester.tap(find.text('Historia'));
    await tester.pumpAndSettle();
    expect(find.text('Jesienny konkurs'), findsOneWidget);

    await tester.tap(find.text('Jesienny konkurs'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Ada'), findsOneWidget);
  });

  testWidgets('new contest dialog returns trimmed name and carry choice', (
    tester,
  ) async {
    StartNewContestResult? result;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => FilledButton(
            onPressed: () async {
              result = await showDialog<StartNewContestResult>(
                context: context,
                builder: (_) => const StartNewContestDialog(),
              );
            },
            child: const Text('Open'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '  Nowy konkurs  ');
    await tester.tap(find.text('Przenieś uczestników'));
    await tester.tap(find.text('Utwórz'));
    await tester.pumpAndSettle();

    expect(result?.name, 'Nowy konkurs');
    expect(result?.carryParticipants, isTrue);
  });
}
