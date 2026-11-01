import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/speakers/domain/entities/speaker_list_item.dart';
import 'package:ng_poland_conf_app/features/speakers/domain/services/speaker_sessions.dart';

void main() {
  test('splits combined titles and classifies each session', () {
    final sessions = speakerSessions(
      'Keynote: Signals + Panel Q&A + Deep dive',
    );

    expect(sessions.map((session) => session.kind), [
      SpeakerSessionKind.keynote,
      SpeakerSessionKind.qa,
      SpeakerSessionKind.talk,
    ]);
    expect(sessions.last.title, 'Deep dive');
  });

  test('returns no sessions for an empty title', () {
    expect(speakerSessions(''), isEmpty);
  });
}
