// The size property of the custom widget now needs to be used for both width and height.
// Let's assume you'll use a slightly modified version of the previous custom widget
// that accepts width and height, or just a single size parameter for simplicity.

// Reverting to the simpler custom widget structure for minimal styling:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

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
    final imageProvider = NetworkImage(imageUrl);

    return Image(
      image: imageProvider,
      width: width,
      height: height ?? width, // Use width for height if height is null
      fit: BoxFit.cover,

      // --- Error Handling ---
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(placeholderAsset,
            width: width, height: height ?? width);
      },

      // --- Loading and CORS Fix ---
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          // --- CRUCIAL WEB FIX ---
          if (kIsWeb) {
            // After the image loads, apply the crossOrigin attribute
            html.document
                .querySelectorAll('img[src="$imageUrl"]')
                .forEach((element) {
              (element as html.ImageElement).crossOrigin = 'anonymous';
            });
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
