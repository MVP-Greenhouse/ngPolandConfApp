class EditionFetch {
  const EditionFetch.ok({required this.body, this.etag}) : notModified = false;

  const EditionFetch.notModified({this.etag}) : body = null, notModified = true;

  final String? body;
  final String? etag;
  final bool notModified;
}

class EditionCacheEntry {
  const EditionCacheEntry({
    required this.body,
    required this.etag,
    required this.fetchedAt,
  });

  final String body;
  final String? etag;
  final DateTime fetchedAt;

  EditionCacheEntry copyWith({String? etag, DateTime? fetchedAt}) {
    return EditionCacheEntry(
      body: body,
      etag: etag ?? this.etag,
      fetchedAt: fetchedAt ?? this.fetchedAt,
    );
  }
}

abstract class EditionRemote {
  Future<EditionFetch> get(String path, {String? etag});
}

abstract class EditionCache {
  Future<EditionCacheEntry?> read(String resource);

  Future<void> write(String resource, EditionCacheEntry entry);
}
