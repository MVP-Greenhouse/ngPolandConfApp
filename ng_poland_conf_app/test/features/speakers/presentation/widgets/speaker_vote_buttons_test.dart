import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/speaker_vote_value.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/widgets/speaker_vote_buttons.dart';

void main() {
  testWidgets('highlights only the user vote and reports taps', (tester) async {
    SpeakerVoteValue? tapped;
    await tester.pumpWidget(
      MaterialApp(
        home: SpeakerVoteButtons(
          current: SpeakerVoteValue.up,
          enabled: true,
          onTap: (value) => tapped = value,
        ),
      ),
    );
    expect(find.byKey(const Key('vote-up')), findsOneWidget);
    expect(find.byKey(const Key('vote-down')), findsOneWidget);
    await tester.tap(find.byKey(const Key('vote-down')));
    expect(tapped, SpeakerVoteValue.down);
  });

  testWidgets('does not show counts', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SpeakerVoteButtons(
          current: SpeakerVoteValue.up,
          enabled: true,
          onTap: _noop,
        ),
      ),
    );
    expect(find.textContaining('128'), findsNothing);
    expect(find.text('👍'), findsNothing);
  });
}

void _noop(SpeakerVoteValue value) {}
