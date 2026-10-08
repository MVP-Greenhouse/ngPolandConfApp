import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/hive_constants.dart';
import 'package:ng_poland_conf_app/core/services/hive_service.dart';
import 'package:ng_poland_conf_app/features/edition/domains/repositories/edition_store.dart';

@LazySingleton(as: EditionCache)
class EditionHiveCache implements EditionCache {
  static const _box = HiveConstantsForBoxes.editionCache;

  @override
  Future<EditionCacheEntry?> read(String resource) async {
    final body = await HiveService.get<String>(_box, '${resource}Body');
    if (body == null || body.isEmpty) return null;
    final etag = await HiveService.get<String>(_box, '${resource}Etag');
    final fetchedAtRaw = await HiveService.get<String>(_box, '${resource}At');
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
    await HiveService.save<String>(_box, '${resource}Body', entry.body);
    await HiveService.save<String>(_box, '${resource}Etag', entry.etag ?? '');
    await HiveService.save<String>(
      _box,
      '${resource}At',
      entry.fetchedAt.toUtc().toIso8601String(),
    );
  }
}
