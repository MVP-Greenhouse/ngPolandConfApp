import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:ng_poland_conf_app/features/edition/data/datasources/edition_cache_datasource.dart';
import 'package:ng_poland_conf_app/features/edition/data/datasources/edition_remote_datasource.dart';
import 'package:ng_poland_conf_app/features/edition/data/mappers/edition_parser.dart';
import 'package:ng_poland_conf_app/features/edition/data/models/edition_cache_entry.dart';
import 'package:ng_poland_conf_app/features/edition/data/models/edition_fetch.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/edition.dart';
import 'package:ng_poland_conf_app/features/edition/domain/exceptions/edition_unavailable_exception.dart';
import 'package:ng_poland_conf_app/features/edition/domain/repositories/edition_repository.dart';
import 'package:ng_poland_conf_app/features/edition/domain/services/edition_cache_freshness.dart';

typedef EditionFetcher = Future<EditionFetch> Function({String? etag});

@LazySingleton(as: EditionRepository)
class EditionRepositoryImpl implements EditionRepository {
  EditionRepositoryImpl(this._remote, this._cache, this._logger);

  final EditionRemote _remote;
  final EditionCache _cache;
  final Logger _logger;

  /// Clock and parser are replaceable so tests stay deterministic and do not
  /// spawn isolates.
  @visibleForTesting
  DateTime Function() now = DateTime.now;
  @visibleForTesting
  Future<Edition> Function(EditionBodies bodies) parse = _parseInBackground;

  Edition? _memory;
  DateTime? _memoryAt;
  Future<Edition>? _loading;

  static Future<Edition> _parseInBackground(EditionBodies bodies) =>
      compute(parseEditionBodies, bodies);

  /// Concurrent callers share one download.
  @override
  Future<Edition> load() =>
      _loading ??= _load().whenComplete(() => _loading = null);

  Future<Edition> _load() async {
    final now = this.now();
    if ((_memory, _memoryAt) case (
      final memory?,
      final memoryAt?,
    ) when editionCacheIsFresh(fetchedAt: memoryAt, now: now)) {
      return memory;
    }

    final agenda = await _body('agenda', _remote.agenda);
    final speakers = await _body('speakers', _remote.speakers);
    if (agenda == null || speakers == null) return _memoryOrThrow();

    try {
      final edition = await parse((agenda: agenda, speakers: speakers));
      _memory = edition;
      _memoryAt = now;
      return edition;
    } on FormatException catch (error, stackTrace) {
      _logger.w(
        'Edition: cached payload is invalid',
        error: error,
        stackTrace: stackTrace,
      );
      return _memoryOrThrow();
    }
  }

  @override
  Future<Edition> refresh() async {
    final agenda = await _freshBody('agenda', _remote.agenda);
    final speakers = await _freshBody('speakers', _remote.speakers);
    final Edition edition;
    try {
      edition = await parse((agenda: agenda, speakers: speakers));
    } on FormatException catch (error, stackTrace) {
      _logger.w(
        'Edition: refreshed payload is invalid',
        error: error,
        stackTrace: stackTrace,
      );
      throw const EditionUnavailableException();
    }
    _memory = edition;
    _memoryAt = now();
    return edition;
  }

  Edition _memoryOrThrow() =>
      _memory ?? (throw const EditionUnavailableException());

  Future<String> _freshBody(String resource, EditionFetcher fetch) async {
    final cached = await _cache.read(resource);
    final EditionFetch result;
    try {
      result = await fetch(etag: cached?.etag);
    } catch (error, stackTrace) {
      _logger.w(
        'Edition: refresh of $resource failed',
        error: error,
        stackTrace: stackTrace,
      );
      throw const EditionUnavailableException();
    }

    final fetchedAt = now();
    if (result.notModified) {
      if (cached == null) throw const EditionUnavailableException();
      await _cache.write(
        resource,
        cached.copyWith(etag: result.etag, fetchedAt: fetchedAt),
      );
      return cached.body;
    }

    final body = result.body;
    if (body == null || body.isEmpty) {
      throw const EditionUnavailableException();
    }
    await _cache.write(
      resource,
      EditionCacheEntry(body: body, etag: result.etag, fetchedAt: fetchedAt),
    );
    return body;
  }

  Future<String?> _body(String resource, EditionFetcher fetch) async {
    final cached = await _cache.read(resource);
    final now = this.now();
    if (cached != null &&
        editionCacheIsFresh(fetchedAt: cached.fetchedAt, now: now)) {
      return cached.body;
    }

    try {
      final result = await fetch(etag: cached?.etag);
      if (result.notModified) {
        if (cached == null) return null;
        await _cache.write(
          resource,
          cached.copyWith(etag: result.etag, fetchedAt: now),
        );
        return cached.body;
      }
      final body = result.body;
      if (body == null || body.isEmpty) return cached?.body;
      await _cache.write(
        resource,
        EditionCacheEntry(body: body, etag: result.etag, fetchedAt: now),
      );
      return body;
    } catch (error, stackTrace) {
      // Offline or server error: fall back to the cached body (if any).
      _logger.i(
        'Edition: fetching $resource failed, using cache',
        error: error,
        stackTrace: stackTrace,
      );
      return cached?.body;
    }
  }
}
