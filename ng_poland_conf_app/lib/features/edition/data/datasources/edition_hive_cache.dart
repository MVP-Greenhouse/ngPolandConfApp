import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/hive_constants.dart';
import 'package:ng_poland_conf_app/core/data/hive_store.dart';
import 'package:ng_poland_conf_app/features/edition/data/datasources/edition_cache_datasource.dart';
import 'package:ng_poland_conf_app/features/edition/data/models/edition_cache_entry.dart';

@LazySingleton(as: EditionCache)
class EditionHiveCache implements EditionCache {
  const EditionHiveCache(this._store);

  static const _box = HiveConstantsForBoxes.editionCache;

  final HiveStore _store;

  @override
  Future<EditionCacheEntry?> read(String resource) async {
    final body = await _store.get<String>(_box, '${resource}Body');
    if (body == null || body.isEmpty) return null;
    final etag = await _store.get<String>(_box, '${resource}Etag');
    final fetchedAtRaw = await _store.get<String>(_box, '${resource}At');
    final fetchedAt = DateTime.tryParse(fetchedAtRaw ?? '');
    if (fetchedAt == null) return null;
    return EditionCacheEntry(
      body: body,
      etag: etag,
      fetchedAt: fetchedAt.toUtc(),
    );
  }

  @override
  Future<void> write(String resource, EditionCacheEntry entry) async {
    await _store.save<String>(_box, '${resource}Body', entry.body);
    await _store.save<String>(_box, '${resource}Etag', entry.etag ?? '');
    await _store.save<String>(
      _box,
      '${resource}At',
      entry.fetchedAt.toUtc().toIso8601String(),
    );
  }
}
