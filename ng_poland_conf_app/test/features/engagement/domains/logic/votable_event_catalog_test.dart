import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/edition/domains/logic/edition_parser.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/votable_event_catalog.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/logic/conference_datetime.dart';
import 'package:timezone/data/latest.dart' as tzdata;

void main() {
  setUpAll(tzdata.initializeTimeZones);

  test('keeps published talks with an end time', () {
    final edition = EditionParser.parse(agenda: _agenda, speakers: _speakers);
    final catalog = votableEventsFromEdition(edition);

    expect(catalog.skippedWithoutEnd, 1);
    expect(catalog.events, hasLength(1));
    expect(catalog.events.single.eventId, '2');
    expect(catalog.events.single.track, EventItemType.ngPoland);
    expect(
      catalog.events.single.endsAt,
      ConferenceDateTime.combineWarsawDateAndHm('2026-11-17', '09:40'),
    );
  });

  test('eventHasEnded is false before endsAt and true at endsAt', () {
    final endsAt = DateTime.utc(2026, 11, 17, 8, 40);

    expect(
      eventHasEnded(
        endsAt: endsAt,
        now: endsAt.subtract(const Duration(minutes: 1)),
      ),
      isFalse,
    );
    expect(eventHasEnded(endsAt: endsAt, now: endsAt), isTrue);
    expect(eventHasEnded(endsAt: null, now: endsAt), isFalse);
  });

  test('sync message counts skipped talks', () {
    final edition = EditionParser.parse(agenda: _agenda, speakers: _speakers);
    expect(
      votableSyncMessage(votableEventsFromEdition(edition)),
      'Synced 1 votable event (1 event skipped without end time)',
    );
  });
}

const _speakers = {'year': 2026, 'speakers': <Map<String, dynamic>>[]};

const _agenda = {
  'year': 2026,
  'days': [
    {
      'key': 'workshops',
      'kind': 'workshops',
      'date': '2026-11-16',
      'published': true,
      'items': [
        {
          'id': 20,
          'title': 'Workshop',
          'speakers': [
            {'name': 'Anna', 'slug': 'anna'},
          ],
        },
      ],
    },
    {
      'key': 'ng',
      'kind': 'conference',
      'conference': 'ng',
      'date': '2026-11-17',
      'published': true,
      'items': [
        {
          'id': 2,
          'isBreak': false,
          'start': '09:00',
          'end': '09:40',
          'title': 'Opening Keynote',
          'speakers': [
            {'name': 'Anna', 'slug': 'anna'},
          ],
        },
        {
          'id': 3,
          'isBreak': true,
          'start': '09:40',
          'end': '10:00',
          'title': 'Break',
          'speakers': <Map<String, dynamic>>[],
        },
        {
          'id': 4,
          'isBreak': false,
          'start': '10:00',
          'end': '10:40',
          'title': 'No speaker',
          'speakers': <Map<String, dynamic>>[],
        },
        {
          'id': 5,
          'isBreak': false,
          'start': '11:00',
          'end': '',
          'title': 'Missing end',
          'speakers': [
            {'name': 'Anna', 'slug': 'anna'},
          ],
        },
      ],
    },
    {
      'key': 'js',
      'kind': 'conference',
      'conference': 'js',
      'date': '2026-11-18',
      'published': false,
      'items': [
        {
          'id': 9,
          'isBreak': false,
          'start': '09:00',
          'end': '09:40',
          'title': 'Unpublished',
          'speakers': [
            {'name': 'Anna', 'slug': 'anna'},
          ],
        },
      ],
    },
  ],
};
