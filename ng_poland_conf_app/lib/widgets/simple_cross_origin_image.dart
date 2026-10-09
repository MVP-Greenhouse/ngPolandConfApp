// The size property of the custom widget now needs to be used for both width and height.
// Let's assume you'll use a slightly modified version of the previous custom widget
// that accepts width and height, or just a single size parameter for simplicity.

// Reverting to the simpler custom widget structure for minimal styling:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/image_helper.dart';
import 'package:ng_poland_conf_app/widgets/app_image_cache.dart';

class SimpleCrossOriginImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double? height;
  final String placeholderAsset;

  const SimpleCrossOriginImage({
    super.key,
    required this.imageUrl,
    required this.width,
    this.height,
    required this.placeholderAsset,
  });

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      final resolvedHeight = height ?? width;
      final ratio = MediaQuery.devicePixelRatioOf(context);
      return CachedNetworkImage(
        imageUrl: imageUrl,
        cacheManager: AppImageCache.instance,
        memCacheWidth: (width * ratio).ceil(),
        memCacheHeight: (resolvedHeight * ratio).ceil(),
        fadeInDuration: Duration.zero,
        fadeOutDuration: Duration.zero,
        width: width,
        height: resolvedHeight,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (_, _, _) =>
            Image.asset(placeholderAsset, width: width, height: resolvedHeight),
        errorWidget: (_, _, _) =>
            Image.asset(placeholderAsset, width: width, height: resolvedHeight),
      );
    }
    final imageProvider = NetworkImage(imageUrl);
    return Image(
      image: imageProvider,
      width: width,
      height: height ?? width, // Use width for height if height is null
      fit: BoxFit.cover,

      // --- Error Handling ---
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          placeholderAsset,
          width: width,
          height: height ?? width,
        );
      },

      // --- Loading and CORS Fix ---
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          if (kIsWeb) {
            applyCrossOriginFix(imageUrl);
          }
          return child;
        }

        // Replicates the progressIndicatorBuilder behavior (using placeholder)
        return Image.asset(
          placeholderAsset,
          width: width,
          height: height ?? width,
        );
      },
    );
  }
}
