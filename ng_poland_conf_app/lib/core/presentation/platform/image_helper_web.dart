import 'dart:js_interop';

import 'package:web/web.dart' as web;

/// Marks rendered `<img>` elements for [imageUrl] as anonymous CORS requests
/// so the CanvasKit renderer can read their pixels.
void applyCrossOriginFix(String imageUrl) {
  final images = web.document.querySelectorAll('img[src="$imageUrl"]');
  for (var i = 0; i < images.length; i++) {
    final node = images.item(i);
    if (node != null && node.isA<web.HTMLImageElement>()) {
      (node as web.HTMLImageElement).crossOrigin = 'anonymous';
    }
  }
}
