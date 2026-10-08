import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/logic/conference_datetime.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

void main() {
  setUpAll(() {
    tzdata.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(ConferenceDateTime.locationName));
  });

  group('ConferenceDateTime.parseToUtc', () {
    test('keeps Contentful UTC instants', () {
      final parsed = ConferenceDateTime.parseToUtc('2026-11-19T08:00:00.000Z');
      expect(parsed, DateTime.utc(2026, 11, 19, 8));
    });

    test('treats naive timestamps as Europe/Warsaw wall-clock', () {
      // 09:00 Warsaw in November = CET (UTC+1) → 08:00 UTC
      final parsed = ConferenceDateTime.parseToUtc('2026-11-19T09:00:00');
      expect(parsed, DateTime.utc(2026, 11, 19, 8));
    });

    test('formats venue-local HH:mm from UTC instant', () {
      expect(
        ConferenceDateTime.formatHm(DateTime.utc(2026, 11, 19, 8)),
        '09:00',
      );
    });
  });

  group('activeScheduleEventId', () {
    final events = [
      (
        id: 'a',
        start: DateTime.utc(2026, 11, 19, 8),
        end: DateTime.utc(2026, 11, 19, 9),
      ),
      (
        id: 'b',
        start: DateTime.utc(2026, 11, 19, 9),
        end: DateTime.utc(2026, 11, 19, 10),
      ),
    ];

    test('returns current event inclusive of start', () {
      expect(
        activeScheduleEventId(
          events: events,
          now: DateTime.utc(2026, 11, 19, 8),
        ),
        'a',
      );
    });

    test('returns null in gap after event end', () {
      expect(
        activeScheduleEventId(
          events: events,
          now: DateTime.utc(2026, 11, 19, 9),
        ),
        'b',
      );
      expect(
        activeScheduleEventId(
          events: [
            (
              id: 'a',
              start: DateTime.utc(2026, 11, 19, 8),
              end: DateTime.utc(2026, 11, 19, 8, 45),
            ),
            (
              id: 'b',
              start: DateTime.utc(2026, 11, 19, 9),
              end: DateTime.utc(2026, 11, 19, 10),
            ),
          ],
          now: DateTime.utc(2026, 11, 19, 8, 50),
        ),
        isNull,
      );
    });
  });

  group('nextActiveScheduleCheckAt', () {
    test('schedules refresh at current event end during an active slot', () {
      final next = nextActiveScheduleCheckAt(
        events: [
          (
            id: 'a',
            start: DateTime.utc(2026, 11, 19, 8),
            end: DateTime.utc(2026, 11, 19, 9),
          ),
          (
            id: 'b',
            start: DateTime.utc(2026, 11, 19, 10),
            end: DateTime.utc(2026, 11, 19, 11),
          ),
        ],
        now: DateTime.utc(2026, 11, 19, 8, 30),
      );
      expect(next, DateTime.utc(2026, 11, 19, 9));
    });
  });

  test('labels the Warsaw offset for the venue instant', () {
    expect(warsawZoneLabel(DateTime.utc(2026, 11, 19, 8)), 'Warsaw (UTC+1)');
    expect(warsawZoneLabel(DateTime.utc(2026, 7, 1, 10)), 'Warsaw (UTC+2)');
  });

  test('formats a slot length', () {
    expect(
      scheduleDurationLabel(
        DateTime.utc(2026, 11, 19, 8),
        DateTime.utc(2026, 11, 19, 8, 20),
      ),
      '20 mins',
    );
    expect(
      scheduleDurationLabel(
        DateTime.utc(2026, 11, 19, 8),
        DateTime.utc(2026, 11, 19, 9),
      ),
      '1 hr',
    );
  });

  test('marks the day upcoming, ongoing, and ended', () {
    final events = [
      (
        start: DateTime.utc(2026, 11, 19, 8),
        end: DateTime.utc(2026, 11, 19, 9),
      ),
    ];
    expect(
      scheduleDayPhase(
        events: events,
        now: DateTime.utc(2026, 11, 19, 7),
        inSlot: false,
      ),
      ScheduleDayPhase.upcoming,
    );
    expect(
      scheduleDayPhase(
        events: events,
        now: DateTime.utc(2026, 11, 19, 8, 30),
        inSlot: true,
      ),
      ScheduleDayPhase.ongoing,
    );
    expect(
      scheduleDayPhase(
        events: events,
        now: DateTime.utc(2026, 11, 19, 12),
        inSlot: false,
      ),
      ScheduleDayPhase.ended,
    );
  });
}
