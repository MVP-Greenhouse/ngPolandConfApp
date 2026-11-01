import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/agenda.dart';
import 'package:ng_poland_conf_app/features/info/domain/services/venue_labels.dart';

AgendaDay _day(String date) => AgendaDay(
  key: date,
  kind: AgendaDayKind.conference,
  conference: null,
  label: '',
  title: '',
  date: date,
  dateLabel: '',
  color: '',
  published: true,
  start: '',
  conferenceItems: const [],
  workshopItems: const [],
);

void main() {
  test('city label strips the postal code and shortens Poland', () {
    expect(venueCityLabel('Złota 59, 00-120 Warsaw, Poland'), 'Warsaw, PL');
    expect(venueCityLabel('Main St 1, Berlin, Germany'), 'Berlin, Germany');
    expect(venueCityLabel('Somewhere'), isNull);
  });

  test('days label mentions consecutive days', () {
    expect(
      agendaDaysLabel([_day('2026-11-16'), _day('2026-11-17')]),
      '2 CONSECUTIVE DAYS',
    );
    expect(agendaDaysLabel([_day('2026-11-16'), _day('2026-11-19')]), '2 DAYS');
    expect(agendaDaysLabel([_day('2026-11-16')]), '1 DAY');
    expect(agendaDaysLabel([_day('soon'), _day('2026-11-17')]), '2 DAYS');
  });
}
