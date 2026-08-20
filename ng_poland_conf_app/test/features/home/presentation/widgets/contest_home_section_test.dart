import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/contest_home_view.dart';
import 'package:ng_poland_conf_app/features/home/presentation/widgets/contest_home_section.dart';

void main() {
  testWidgets('shows join button copy', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ContestHomeSection(
          view: ContestHomeView.join,
          online: true,
          onJoin: () {},
        ),
      ),
    );
    expect(find.text('Dołącz do konkursu'), findsOneWidget);
  });

  testWidgets('shows lose copy only for loser view', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ContestHomeSection(
          view: ContestHomeView.loser,
          online: true,
          onJoin: _noop,
        ),
      ),
    );
    expect(
      find.text('Niestety nie udało się, może innym razem'),
      findsOneWidget,
    );
    expect(find.text('Dołącz do konkursu'), findsNothing);
  });

  testWidgets('winner banner uses spec copy', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ContestHomeSection(
          view: ContestHomeView.winner,
          online: true,
          onJoin: _noop,
        ),
      ),
    );
    expect(
      find.text(
        'Wygrałeś nagrodę w konkursie. Odebrać możesz ją w strefie organizatorów.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('shows joined copy on disabled button', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ContestHomeSection(
          view: ContestHomeView.joined,
          online: true,
          onJoin: _noop,
        ),
      ),
    );
    expect(find.text('Dołączono do konkursu'), findsOneWidget);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
  });
}

void _noop() {}
