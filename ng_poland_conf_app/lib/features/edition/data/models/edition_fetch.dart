/// Raw response of an ng-poland API resource (conditional GET with ETag).
class EditionFetch {
  const EditionFetch.ok({required this.body, this.etag}) : notModified = false;

  const EditionFetch.notModified({this.etag}) : body = null, notModified = true;

  final String? body;
  final String? etag;
  final bool notModified;
}
