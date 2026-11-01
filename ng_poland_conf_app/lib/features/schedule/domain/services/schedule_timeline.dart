import 'package:collection/collection.dart';
import 'package:ng_poland_conf_app/features/edition/domain/services/conference_datetime.dart';
import 'package:timezone/timezone.dart' as tz;

/// Time window of one agenda slot.
typedef ScheduleSlot = ({String id, DateTime? start, DateTime? end});

/// Returns the id of the event happening at [now], or null.
///
/// Slots are inclusive of their start and exclusive of their end.
String? activeScheduleEventId({
  required Iterable<ScheduleSlot> events,
  required DateTime now,
}) {
  final nowUtc = now.toUtc();
  return events.firstWhereOrNull((event) {
    if ((event.start, event.end) case (final start?, final end?)) {
      return !nowUtc.isBefore(start.toUtc()) && nowUtc.isBefore(end.toUtc());
    }
    return false;
  })?.id;
}

/// Next instant when active-event highlighting should be recomputed.
DateTime? nextActiveScheduleCheckAt({
  required Iterable<ScheduleSlot> events,
  required DateTime now,
}) {
  final nowUtc = now.toUtc();
  return [
    for (final event in events)
      if ((event.start, event.end) case (final start?, final end?))
        for (final moment in [start.toUtc(), end.toUtc()])
          if (moment.isAfter(nowUtc)) moment,
  ].minOrNull;
}

/// Venue clock label, for example `Warsaw (UTC+1)` in winter.
String warsawZoneLabel(DateTime instant) {
  final warsaw = tz.TZDateTime.from(
    instant.toUtc(),
    tz.getLocation(ConferenceDateTime.locationName),
  );
  final hours = warsaw.timeZoneOffset.inHours;
  final sign = hours >= 0 ? '+' : '';
  return 'Warsaw (UTC$sign$hours)';
}

/// Short length of a slot, for example `20 mins` or `1 hr`.
String? scheduleDurationLabel(DateTime? start, DateTime? end) {
  if (start == null || end == null) return null;
  final minutes = end.difference(start).inMinutes;
  if (minutes <= 0) return null;
  if (minutes < 60) return '$minutes mins';
  final hours = minutes ~/ 60;
  final rest = minutes % 60;
  if (rest == 0) return hours == 1 ? '1 hr' : '$hours hrs';
  return '${hours}h $rest mins';
}

enum ScheduleDayPhase { upcoming, ongoing, ended }

ScheduleDayPhase scheduleDayPhase({
  required Iterable<ScheduleSlot> events,
  required DateTime now,
  required bool inSlot,
}) {
  if (inSlot) return .ongoing;

  final nowUtc = now.toUtc();
  final firstStart = events
      .map((event) => event.start?.toUtc())
      .nonNulls
      .minOrNull;
  final lastEnd = events.map((event) => event.end?.toUtc()).nonNulls.maxOrNull;
  if (firstStart != null && nowUtc.isBefore(firstStart)) return .upcoming;
  if (lastEnd != null && !nowUtc.isBefore(lastEnd)) return .ended;
  return .ongoing;
}
