import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/widgets/custom_drawer.dart';

void main() {
  testWidgets('hides admin tile when not visible', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AdminDrawerTile(visible: false, selected: false, onTap: () {}),
        ),
      ),
    );
    expect(find.text('Admin'), findsNothing);
  });

  testWidgets('shows admin tile when visible', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AdminDrawerTile(visible: true, selected: false, onTap: () {}),
        ),
      ),
    );
    expect(find.text('Admin'), findsOneWidget);
  });
}
