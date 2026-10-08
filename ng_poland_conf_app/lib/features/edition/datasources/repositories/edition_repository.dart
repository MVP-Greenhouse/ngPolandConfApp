import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/edition/domains/entities/edition.dart';
import 'package:ng_poland_conf_app/features/edition/domains/logic/edition_cache_freshness.dart';
import 'package:ng_poland_conf_app/features/edition/domains/logic/edition_parser.dart';
import 'package:ng_poland_conf_app/features/edition/domains/repositories/edition_store.dart';

@lazySingleton
class EditionRepository {
  EditionRepository(this._remote, this._cache);

  final EditionRemote _remote;
  final EditionCache _cache;
  DateTime Function() now = DateTime.now;

  Edition? _memory;
  DateTime? _memoryAt;

  Future<Edition?> load() async {
    final now = this.now();
    final memory = _memory;
    final memoryAt = _memoryAt;
    if (memory != null &&
        memoryAt != null &&
        editionCacheIsFresh(fetchedAt: memoryAt, now: now)) {
      return memory;
    }

    final agendaBody = await _body('/api/agenda.json', 'agenda');
    final speakersBody = await _body('/api/speakers.json', 'speakers');
    if (agendaBody == null || speakersBody == null) return _memory;

    try {
      final edition = EditionParser.parse(
        agenda: _decode(agendaBody),
        speakers: _decode(speakersBody),
      );
      _memory = edition;
      _memoryAt = now;
      return edition;
    } catch (_) {
      return _memory;
    }
  }

  Future<String?> _body(String path, String resource) async {
    final cached = await _cache.read(resource);
    final now = this.now();
    if (cached != null && editionCacheIsFresh(fetchedAt: cached.fetchedAt, now: now)) {
      return cached.body;
    }

    try {
      final fetch = await _remote.get(path, etag: cached?.etag);
      if (fetch.notModified) {
        if (cached == null) return null;
        await _cache.write(
          resource,
          cached.copyWith(etag: fetch.etag, fetchedAt: now),
        );
        return cached.body;
      }
      final body = fetch.body;
      if (body == null || body.isEmpty) return cached?.body;
      await _cache.write(
        resource,
        EditionCacheEntry(body: body, etag: fetch.etag, fetchedAt: now),
      );
      return body;
    } catch (_) {
      return cached?.body;
    }
  }

  Map<String, dynamic> _decode(String body) {
    final decoded = jsonDecode(body);
    if (decoded is Map<String, dynamic>) return decoded;
    if (decoded is Map) {
      return decoded.map((key, value) => MapEntry('$key', value));
    }
    throw const FormatException('Edition payload is not a JSON object');
  }
}
