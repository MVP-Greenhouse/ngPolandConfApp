import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:ng_poland_conf_app/features/edition/data/datasources/edition_cache_datasource.dart';
import 'package:ng_poland_conf_app/features/edition/data/datasources/edition_remote_datasource.dart';
import 'package:ng_poland_conf_app/features/edition/data/mappers/edition_parser.dart';
import 'package:ng_poland_conf_app/features/edition/data/models/edition_cache_entry.dart';
import 'package:ng_poland_conf_app/features/edition/data/models/edition_fetch.dart';
import 'package:ng_poland_conf_app/features/edition/data/repositories/edition_repository_impl.dart';
import 'package:ng_poland_conf_app/features/edition/domain/exceptions/edition_unavailable_exception.dart';
import 'package:timezone/data/latest.dart' as tzdata;

import '../../../../fixtures/edition_fixtures.dart';

void main() {
  setUpAll(tzdata.initializeTimeZones);

  late _FakeRemote remote;
  late _MemoryCache cache;
  final now = DateTime.utc(2026, 10, 6, 12);

  EditionRepositoryImpl repository({Duration after = Duration.zero}) =>
      EditionRepositoryImpl(remote, cache, Logger(level: Level.off))
        ..now = (() => now.add(after))
        ..parse = (bodies) async => parseEditionBodies(bodies);

  setUp(() {
    remote = _FakeRemote();
    cache = _MemoryCache();
  });

  void serveFreshEdition() => remote.next = {
    'agenda': EditionFetch.ok(body: jsonEncode(editionAgendaJson), etag: 'a1'),
    'speakers': EditionFetch.ok(
      body: jsonEncode(editionSpeakersJson),
      etag: 's1',
    ),
  };

  test('304 and offline errors reuse the cached body', () async {
    serveFreshEdition();
    final first = await repository().load();
    expect(first.confId, '2026');

    remote.next = {
      'agenda': const EditionFetch.notModified(etag: 'a1'),
      'speakers': const EditionFetch.notModified(etag: 's1'),
    };
    final second = await repository(after: const Duration(minutes: 6)).load();
    expect(
      second.dayByKey('ng')?.conferenceItems.single.title,
      'Opening Keynote',
    );

    remote.fail = true;
    final third = await repository(after: const Duration(minutes: 10)).load();
    expect(third.speakers.single.slug, 'anna-kowalska');
  });

  test('concurrent loads share a single download', () async {
    serveFreshEdition();
    final repo = repository();

    await Future.wait([repo.load(), repo.load()]);

    expect(remote.calls, 2, reason: 'one agenda + one speakers request');
  });

  test('load fails with a domain exception when nothing is cached', () async {
    remote.fail = true;

    await expectLater(
      repository().load(),
      throwsA(isA<EditionUnavailableException>()),
    );
  });

  test('refresh fails closed when the network is down', () async {
    serveFreshEdition();
    await repository().load();

    remote.fail = true;
    await expectLater(
      repository(after: const Duration(minutes: 1)).refresh(),
      throwsA(isA<EditionUnavailableException>()),
    );
  });
}

class _FakeRemote implements EditionRemote {
  Map<String, EditionFetch> next = const {};
  bool fail = false;
  int calls = 0;

  @override
  Future<EditionFetch> agenda({String? etag}) => _fetch('agenda');

  @override
  Future<EditionFetch> speakers({String? etag}) => _fetch('speakers');

  Future<EditionFetch> _fetch(String resource) async {
    calls++;
    if (fail) throw Exception('offline');
    return next[resource] ?? (throw StateError('missing $resource'));
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
