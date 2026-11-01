import 'package:ng_poland_conf_app/features/edition/data/models/edition_cache_entry.dart';

abstract interface class EditionCache {
  Future<EditionCacheEntry?> read(String resource);

  Future<void> write(String resource, EditionCacheEntry entry);
}
