import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/event/presentation/widgets/event_vote_button.dart';

void main() {
  testWidgets('tap invokes callback when enabled', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: EventLikeButton(
          liked: false,
          enabled: true,
          onTap: () => tapped = true,
        ),
      ),
    );
    await tester.tap(find.byKey(const Key('event-vote-like')));
    expect(tapped, isTrue);
  });
}
