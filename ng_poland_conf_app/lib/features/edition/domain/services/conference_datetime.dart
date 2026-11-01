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
