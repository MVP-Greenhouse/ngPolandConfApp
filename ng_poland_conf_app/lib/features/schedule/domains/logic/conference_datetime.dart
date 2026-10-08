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

  /// `YYYY-MM-DD` plus `HH:MM` as a Europe/Warsaw wall-clock, returned in UTC.
  static DateTime? combineWarsawDateAndHm(String date, String hm) {
    final dateParts = date.trim().split('-');
    final hmParts = hm.trim().split(':');
    if (dateParts.length != 3 || hmParts.length < 2) return null;
    final year = int.tryParse(dateParts[0]);
    final month = int.tryParse(dateParts[1]);
    final day = int.tryParse(dateParts[2]);
    final hour = int.tryParse(hmParts[0]);
    final minute = int.tryParse(hmParts[1]);
    if (year == null ||
        month == null ||
        day == null ||
        hour == null ||
        minute == null) {
      return null;
    }
    final warsaw = tz.TZDateTime(_warsaw, year, month, day, hour, minute);
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
  required Iterable<({DateTime? start, DateTime? end})> events,
  required DateTime now,
  required bool inSlot,
}) {
  if (inSlot) return ScheduleDayPhase.ongoing;

  DateTime? firstStart;
  DateTime? lastEnd;
  for (final event in events) {
    final start = event.start?.toUtc();
    final end = event.end?.toUtc();
    if (start != null && (firstStart == null || start.isBefore(firstStart))) {
      firstStart = start;
    }
    if (end != null && (lastEnd == null || end.isAfter(lastEnd))) {
      lastEnd = end;
    }
  }

  final nowUtc = now.toUtc();
  if (firstStart != null && nowUtc.isBefore(firstStart)) {
    return ScheduleDayPhase.upcoming;
  }
  if (lastEnd != null && !nowUtc.isBefore(lastEnd)) {
    return ScheduleDayPhase.ended;
  }
  return ScheduleDayPhase.ongoing;
}
