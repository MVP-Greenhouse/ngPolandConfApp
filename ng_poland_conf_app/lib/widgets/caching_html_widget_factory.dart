import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:ng_poland_conf_app/widgets/app_image_cache.dart';

/// Renders HTML `<img>` tags through the same disk cache as speaker photos.
class CachingHtmlWidgetFactory extends WidgetFactory {
  @override
  ImageProvider? imageProviderFromNetwork(String url) {
    if (kIsWeb || url.isEmpty) return super.imageProviderFromNetwork(url);
    return CachedNetworkImageProvider(
      url,
      cacheManager: AppImageCache.instance,
    );
  }
}
