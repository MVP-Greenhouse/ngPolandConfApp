import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// Web keeps the browser cache. Disk cache is the IO implementation.
class AppImageCache {
  static CacheManager get instance =>
      throw UnsupportedError('Disk image cache is only used off the web.');
}
