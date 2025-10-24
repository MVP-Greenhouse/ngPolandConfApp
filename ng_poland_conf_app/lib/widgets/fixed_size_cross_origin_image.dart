import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/image_helper.dart';

class FixedSizeCrossOriginImage extends StatelessWidget {
  final String imageUrl;
  final double size; // Accepts a fixed size (e.g., 50.0)
  final String placeholderAsset;

  const FixedSizeCrossOriginImage({
    super.key,
    required this.imageUrl,
    required this.size,
    required this.placeholderAsset,
  });

  @override
  Widget build(BuildContext context) {
    final imageProvider = NetworkImage(imageUrl);

    return SizedBox(
      width: size,
      height: size,
      // Use Image as the container for the loading logic
      child: Image(
        image: imageProvider,
        fit: BoxFit.cover,

        // --- Error Handling ---
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(placeholderAsset, width: size, height: size);
        },

        // --- Loading and CORS Fix ---
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            if (kIsWeb) {
              applyCrossOriginFix(imageUrl);
            }

            // Replicates the imageBuilder circular styling
            return Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider, // Use the already fetched imageProvider
                  fit: BoxFit.cover,
                ),
              ),
            );
          }

          // Progress/Placeholder
          return Image.asset(placeholderAsset, width: size, height: size);
        },
      ),
    );
  }
}
