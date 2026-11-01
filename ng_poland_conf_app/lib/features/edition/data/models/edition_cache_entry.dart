/// A cached API body together with its ETag and download time.
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
