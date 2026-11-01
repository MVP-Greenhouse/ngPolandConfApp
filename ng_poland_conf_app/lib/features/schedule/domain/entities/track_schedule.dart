import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item.dart';

/// Agenda of one conference track.
class TrackSchedule {
  const TrackSchedule({required this.events, required this.published});

  final List<EventItem> events;

  /// `false` while the organisers have not published the day's agenda yet.
  final bool published;
}
