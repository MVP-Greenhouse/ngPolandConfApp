import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/core/data/json_object.dart';
import 'package:ng_poland_conf_app/features/edition/data/mappers/edition_parser.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/edition/domain/services/conference_datetime.dart';
import 'package:ng_poland_conf_app/features/edition/domain/services/edition_cache_freshness.dart';
import 'package:ng_poland_conf_app/features/edition/domain/services/edition_projections.dart';
import 'package:timezone/data/latest.dart' as tzdata;

import '../../../../fixtures/edition_fixtures.dart';

void main() {
  setUpAll(tzdata.initializeTimeZones);

  test('parses agenda days and joins speakers by slug', () {
    final edition = EditionParser.parse(
      agenda: const JsonObject(editionAgendaJson),
      speakers: const JsonObject(editionSpeakersJson),
    );

    expect(edition.confId, '2026');
    expect(edition.venue?.name, 'Multikino');
    expect(edition.days, hasLength(3));
    expect(edition.dayByKey('js')?.published, isFalse);
    expect(edition.dayByKey('workshops')?.homeName, 'Hands-on Workshops Day');
    expect(
      edition.speakerBySlug('anna-kowalska')?.talk?.title,
      'Signals Deep Dive',
    );

    final events = eventItemsForTrack(
      edition: edition,
      track: EventItemType.ngPoland,
    );
    expect(events, hasLength(1));
    expect(events.single.id, '2');
    expect(events.single.speakerNames, 'Anna Kowalska');
    expect(events.single.isBreak, isFalse);
    expect(events.single.hasSpeaker, isTrue);

    final comingSoon = eventItemsForTrack(
      edition: edition,
      track: EventItemType.jsPoland,
    );
    expect(comingSoon, isEmpty);
  });

  test('combines a Warsaw wall-clock date and time', () {
    final instant = ConferenceDateTime.combineWarsawDateAndHm(
      '2026-11-17',
      '09:00',
    );
    expect(instant, DateTime.utc(2026, 11, 17, 8));
    expect(ConferenceDateTime.combineWarsawDateAndHm('2026-11-17', ''), isNull);
  });

  test('cache stays fresh for five minutes', () {
    final fetchedAt = DateTime.utc(2026, 10, 6, 12);
    expect(
      editionCacheIsFresh(
        fetchedAt: fetchedAt,
        now: fetchedAt.add(const Duration(minutes: 4)),
      ),
      isTrue,
    );
    expect(
      editionCacheIsFresh(
        fetchedAt: fetchedAt,
        now: fetchedAt.add(const Duration(minutes: 5)),
      ),
      isFalse,
    );
  });
}
