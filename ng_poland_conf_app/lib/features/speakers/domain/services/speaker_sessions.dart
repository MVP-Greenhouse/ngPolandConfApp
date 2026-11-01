import 'package:ng_poland_conf_app/features/speakers/domain/entities/speaker_list_item.dart';

/// Splits a combined talk title (`Talk + Q&A`) into its sessions.
List<SpeakerSession> speakerSessions(String talkTitle) => [
  for (final part in talkTitle.split(' + '))
    if (part.trim() case final title when title.isNotEmpty)
      SpeakerSession(kind: _kindOf(title), title: title),
];

SpeakerSessionKind _kindOf(String title) => switch (title.toLowerCase()) {
  final lower when lower.contains('q&a') || lower.contains('q & a') => .qa,
  final lower when lower.startsWith('keynote') => .keynote,
  _ => .talk,
};
