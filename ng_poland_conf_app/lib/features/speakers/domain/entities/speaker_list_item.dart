import 'package:ng_poland_conf_app/features/edition/domain/entities/speaker.dart';

enum SpeakerSessionKind { talk, keynote, qa }

class SpeakerSession {
  const SpeakerSession({required this.kind, required this.title});

  final SpeakerSessionKind kind;
  final String title;
}

/// A speaker as shown on the speakers list.
class SpeakerListItem {
  const SpeakerListItem({
    required this.speaker,
    required this.position,
    required this.company,
    required this.color,
    required this.sessions,
  });

  final Speaker speaker;
  final String position;
  final String company;

  /// Conference accent colour as a hex string (may be empty).
  final String color;
  final List<SpeakerSession> sessions;
}
