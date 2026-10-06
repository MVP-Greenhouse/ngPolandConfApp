import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

/// NG Poland schedule times are authored for the Warsaw venue.
///
/// - ISO strings with `Z` / offset → absolute instants (Contentful Date).
/// - Naive ISO strings → Europe/Warsaw wall-clock.
class ConferenceDateTime {
  const ConferenceDateTime._();

  static const locationName = 'Europe/Warsaw';

  static tz.Location get _warsaw => tz.getLocation(locationName);

  /// Parses a CMS date string into a UTC [DateTime] instant.
  static DateTime? parseToUtc(String? raw) {
    if (raw == null || raw.trim().isEmpty) return null;
    final parsed = DateTime.tryParse(raw.trim());
    if (parsed == null) return null;
    if (parsed.isUtc) return parsed.toUtc();

    final warsaw = tz.TZDateTime(
      _warsaw,
      parsed.year,
      parsed.month,
      parsed.day,
      parsed.hour,
      parsed.minute,
      parsed.second,
      parsed.millisecond,
      parsed.microsecond,
    );
    return warsaw.toUtc();
  }

  /// Formats an instant as HH:mm in Europe/Warsaw (venue local time).
  static String formatHm(DateTime? instant) {
    if (instant == null) return '';
    final warsaw = tz.TZDateTime.from(instant.toUtc(), _warsaw);
    return DateFormat.Hm().format(warsaw);
  }
}

/// Returns the id of the event happening at [now], or null.
String? activeScheduleEventId({
  required Iterable<({String id, DateTime? start, DateTime? end})> events,
  required DateTime now,
}) {
  final nowUtc = now.toUtc();
  for (final event in events) {
    final start = event.start?.toUtc();
    final end = event.end?.toUtc();
    if (start == null || end == null) continue;
    // Inclusive start, exclusive end: [start, end)
    if (!nowUtc.isBefore(start) && nowUtc.isBefore(end)) {
      return event.id;
    }
  }
  return null;
}

/// Next instant when active-event highlighting should be recomputed.
DateTime? nextActiveScheduleCheckAt({
  required Iterable<({String id, DateTime? start, DateTime? end})> events,
  required DateTime now,
}) {
  final nowUtc = now.toUtc();
  DateTime? soonest;
  for (final event in events) {
    final start = event.start?.toUtc();
    final end = event.end?.toUtc();
    if (start == null || end == null) continue;
    if (start.isAfter(nowUtc)) {
      soonest = _minDate(soonest, start);
    }
    if (end.isAfter(nowUtc)) {
      soonest = _minDate(soonest, end);
    }
  }
  return soonest;
}

DateTime? _minDate(DateTime? a, DateTime b) {
  if (a == null || b.isBefore(a)) return b;
  return a;
}
