import 'package:ng_poland_conf_app/features/edition/domain/entities/agenda.dart';

final _postalCode = RegExp(r'^\d{2}-\d{3}\s+');

/// `Street 1, 00-001 Warsaw, Poland` → `Warsaw, PL`.
String? venueCityLabel(String address) {
  final parts = [
    for (final part in address.split(','))
      if (part.trim() case final trimmed when trimmed.isNotEmpty) trimmed,
  ];
  if (parts case [..., final cityPart, final country]) {
    final city = cityPart.replaceFirst(_postalCode, '');
    if (city.isEmpty) return null;
    final countryLabel = country.toLowerCase() == 'poland' ? 'PL' : country;
    return '$city, $countryLabel';
  }
  return null;
}

/// `3 CONSECUTIVE DAYS`, `2 DAYS` or `1 DAY`.
String agendaDaysLabel(List<AgendaDay> days) {
  final count = days.length;
  final unit = count == 1 ? 'DAY' : 'DAYS';
  return count > 1 && _consecutive(days)
      ? '$count CONSECUTIVE $unit'
      : '$count $unit';
}

bool _consecutive(List<AgendaDay> days) {
  final dates = [for (final day in days) ?DateTime.tryParse(day.date)];
  if (dates.length != days.length) return false;
  return [
    for (var i = 1; i < dates.length; i++)
      dates[i].difference(dates[i - 1]).inDays,
  ].every((gap) => gap == 1);
}
