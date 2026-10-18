import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item.dart';

/// Longest description that still fits on a schedule card as a one-line note.
const scheduleCardNoteMaxLength = 72;

/// Short description shown on the schedule card, or `null` when the
/// description is missing, too long, multi-line or repeats the session label.
String? scheduleCardNote(EventItem event) {
  final description = event.description?.trim() ?? '';
  if (description.isEmpty ||
      description.length > scheduleCardNoteMaxLength ||
      description.contains('\n') ||
      description == event.sessionLabel.trim()) {
    return null;
  }
  return description;
}
