import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// How long a downloaded image stays valid on disk.
///
/// [HttpGetResponse] copies `Cache-Control`. `no-cache` and `max-age=0` make
/// [CacheManager] treat the file as expired and download it again on the next
/// view. Conference photos are overwritten rarely, so the stored file stays
/// valid for this long instead.
const imageCacheLifetime = Duration(days: 30);

/// Disk cache shared by speaker photos, covers, thumbnails and HTML images.
class AppImageCache {
  static const cacheKey = 'ngPolandImages';

  static final CacheManager instance = _Manager();
}

class _Manager extends CacheManager with ImageCacheManager {
  _Manager()
    : super(
        Config(
          AppImageCache.cacheKey,
          stalePeriod: imageCacheLifetime,
          maxNrOfCacheObjects: 500,
          fileService: _KeepingFileService(),
        ),
      );
}

class _KeepingFileService extends FileService {
  final HttpFileService _http = HttpFileService();

  @override
  Future<FileServiceResponse> get(
    String url, {
    Map<String, String>? headers,
  }) async {
    final response = await _http.get(url, headers: headers);
    return KeptImageResponse(response);
  }
}

/// Same bytes as [inner], with [validTill] fixed to [imageCacheLifetime].
class KeptImageResponse implements FileServiceResponse {
  KeptImageResponse(this.inner, {DateTime? now})
    : validTill = (now ?? DateTime.now()).add(imageCacheLifetime);

  final FileServiceResponse inner;

  @override
  final DateTime validTill;

  @override
  Stream<List<int>> get content => inner.content;

  @override
  int? get contentLength => inner.contentLength;

  @override
  int get statusCode => inner.statusCode;

  @override
  String? get eTag => inner.eTag;

  @override
  String get fileExtension => inner.fileExtension;
}
