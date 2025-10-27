import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/image_helper.dart';

class CrossOriginImage extends StatelessWidget {
  final String imageUrl;
  final String placeholderAsset;
  final double sizeFactor; // New parameter to handle dynamic sizing

  const CrossOriginImage({
    super.key,
    required this.imageUrl,
    required this.placeholderAsset,
    this.sizeFactor = 0.3, // Default to 0.3 if not provided
  });

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.sizeOf(context).width * sizeFactor;
    if (Platform.isAndroid || Platform.isIOS) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        progressIndicatorBuilder: (_, __, ___) => Image.asset(placeholderAsset),
        errorWidget: (_, url, dynamic error) {
          return Image.asset(placeholderAsset);
        },
        imageBuilder: (_, imageProvider) => SizedBox(
          width: size,
          height: size,
          child: CircleAvatar(
            radius: 25,
            backgroundImage: imageProvider,
          ),
        ),
      );
    }
    final imageProvider = NetworkImage(imageUrl);
    return SizedBox(
      width: size,
      height: size,
      // Use Image.asset as the base error and placeholder container
      child: Image(
        image: imageProvider,
        fit: BoxFit.cover,

        // --- Error Handling ---
        errorBuilder: (context, error, stackTrace) {
          // Replicates the errorWidget behavior
          return Image.asset(placeholderAsset, width: size, height: size);
        },

        // --- Loading and CORS Fix ---
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            if (kIsWeb) {
              applyCrossOriginFix(imageUrl);
            }

            // Replicates the imageBuilder logic using CircleAvatar
            return CircleAvatar(
              radius: size / 2, // Radius is half the diameter (size)
              backgroundImage: imageProvider, // Use the same provider
            );
          }

          // Replicates the progressIndicatorBuilder behavior (using placeholder)
          return Image.asset(
            placeholderAsset,
            width: size,
            height: size,
          );
        },
      ),
    );
  }
}
