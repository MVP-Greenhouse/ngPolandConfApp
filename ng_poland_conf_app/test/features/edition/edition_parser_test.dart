import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/edition/domains/logic/edition_cache_freshness.dart';
import 'package:ng_poland_conf_app/features/edition/domains/logic/edition_parser.dart';
import 'package:ng_poland_conf_app/features/edition/domains/logic/edition_projections.dart';
import 'package:ng_poland_conf_app/features/edition/domains/repositories/edition_store.dart';
import 'package:ng_poland_conf_app/features/edition/datasources/repositories/edition_repository.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/logic/conference_datetime.dart';
import 'package:timezone/data/latest.dart' as tzdata;

void main() {
  setUpAll(tzdata.initializeTimeZones);

  test('parses agenda days and joins speakers by slug', () {
    final edition = EditionParser.parse(agenda: _agenda, speakers: _speakers);

    expect(edition.confId, '2026');
    expect(edition.venue?.name, 'Multikino');
    expect(edition.days, hasLength(3));
    expect(edition.dayByKey('js')?.published, isFalse);
    expect(edition.dayByKey('workshops')?.homeName, 'Hands-on Workshops Day');
    expect(edition.speakerBySlug('anna-kowalska')?.talk?.title, 'Signals Deep Dive');

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

  test('304 and offline errors reuse the cached body', () async {
    final remote = _FakeRemote();
    final cache = _MemoryCache();
    final now = DateTime.utc(2026, 10, 6, 12);
    final repository = EditionRepository(remote, cache)..now = () => now;

    remote.next = {
      '/api/agenda.json': EditionFetch.ok(body: _encode(_agenda), etag: 'a1'),
      '/api/speakers.json': EditionFetch.ok(body: _encode(_speakers), etag: 's1'),
    };
    final first = await repository.load();
    expect(first?.confId, '2026');

    remote.next = {
      '/api/agenda.json': const EditionFetch.notModified(etag: 'a1'),
      '/api/speakers.json': const EditionFetch.notModified(etag: 's1'),
    };
    remote.fail = false;
    final staleClock = EditionRepository(remote, cache)
      ..now = () => now.add(const Duration(minutes: 6));
    final second = await staleClock.load();
    expect(second?.dayByKey('ng')?.conferenceItems.single.title, 'Opening Keynote');

    remote.fail = true;
    final offline = EditionRepository(remote, cache)
      ..now = () => now.add(const Duration(minutes: 10));
    final third = await offline.load();
    expect(third?.speakers.single.slug, 'anna-kowalska');
  });
}

String _encode(Map<String, dynamic> json) => jsonEncode(json);

class _FakeRemote implements EditionRemote {
  Map<String, EditionFetch> next = const {};
  bool fail = false;

  @override
  Future<EditionFetch> get(String path, {String? etag}) async {
    if (fail) throw Exception('offline');
    return next[path] ?? (throw StateError('missing $path'));
  }
}

class _MemoryCache implements EditionCache {
  final entries = <String, EditionCacheEntry>{};

  @override
  Future<EditionCacheEntry?> read(String resource) async => entries[resource];

  @override
  Future<void> write(String resource, EditionCacheEntry entry) async {
    entries[resource] = entry;
  }
}

const _agenda = {
  'year': 2026,
  'ticketsUrl': 'https://tickets.example',
  'venue': {
    'name': 'Multikino',
    'address': 'Złota 59',
    'mapsUrl': 'https://maps.example',
  },
  'days': [
    {
      'key': 'workshops',
      'kind': 'workshops',
      'label': 'Workshops',
      'title': 'Hands-on Workshops Day',
      'date': '2026-11-16',
      'dateLabel': 'Nov 16, 2026',
      'color': '#2f8fed',
      'published': true,
      'start': '10:00',
      'items': [
        {
          'id': 20,
          'title': 'Angular Signals Workshop',
          'cardTitle': '',
          'conference': 'ng',
          'conferenceLabel': 'NG Poland',
          'color': '#F230BF',
          'level': 'Intermediate',
          'benefits': ['Learn signals'],
          'description': 'Full day.',
          'descriptionHtml': '<p>Full day.</p>',
          'pricePln': 1490,
          'priceEur': null,
          'buyUrl': 'https://buy.example',
          'lunchProvided': true,
          'timeLabel': '10:00 - 17:00',
          'speakers': [
            {
              'name': 'Anna Kowalska',
              'slug': 'anna-kowalska',
              'position': 'GDE',
              'company': 'Acme',
              'photo': 'https://ng-poland.pl/images/speakers/anna.webp',
            },
          ],
        },
      ],
    },
    {
      'key': 'ng',
      'kind': 'conference',
      'conference': 'ng',
      'label': 'NG Poland',
      'date': '2026-11-17',
      'dateLabel': 'Nov 17, 2026',
      'color': '#F230BF',
      'published': true,
      'items': [
        {
          'id': 2,
          'type': 'keynote',
          'icon': 'fa-microphone',
          'isBreak': false,
          'session': 1,
          'sessionLabel': 'Session One',
          'start': '09:00',
          'end': '09:40',
          'timeLabel': '09:00 - 09:40',
          'title': 'Opening Keynote',
          'descriptionHtml': '<p>Hi</p>',
          'description': 'Hi',
          'speakers': [
            {
              'name': 'Anna Kowalska',
              'slug': 'anna-kowalska',
              'position': 'GDE',
              'company': 'Acme',
              'photo': 'https://ng-poland.pl/images/speakers/anna.webp',
            },
          ],
        },
      ],
    },
    {
      'key': 'js',
      'kind': 'conference',
      'conference': 'js',
      'label': 'JS Poland',
      'date': '2026-11-18',
      'dateLabel': 'Nov 18, 2026',
      'published': false,
      'items': [],
    },
  ],
};

const _speakers = {
  'year': 2026,
  'speakers': [
    {
      'id': 10,
      'slug': 'anna-kowalska',
      'name': 'Anna Kowalska',
      'conference': 'ng',
      'conferenceLabel': 'NG Poland',
      'position': 'GDE',
      'company': 'Acme',
      'photo': 'https://ng-poland.pl/images/speakers/anna.webp',
      'bio': 'GDE & author',
      'bioHtml': '<p>GDE</p>',
      'talk': {
        'title': 'Signals Deep Dive',
        'description': 'All about signals.',
        'descriptionHtml': '<p>All about signals.</p>',
      },
      'socials': [
        {'network': 'linkedin', 'url': 'https://www.linkedin.com/in/anna'},
      ],
      'books': [],
      'videos': [],
      'workshops': [],
      'agendaItems': [
        {'id': 2, 'title': 'Opening Keynote', 'conference': 'ng'},
      ],
    },
  ],
};
