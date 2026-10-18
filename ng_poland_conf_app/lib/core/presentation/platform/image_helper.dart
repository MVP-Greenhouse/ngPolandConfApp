// Web needs a CORS fix for network images; other platforms get a no-op.
export 'image_helper_stub.dart'
    if (dart.library.js_interop) 'image_helper_web.dart';
