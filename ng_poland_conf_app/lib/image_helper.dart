// lib/image_helper.dart

// Conditional import: The 'dart.library.html' environment constant
// is true ONLY when compiling for web.
export 'platform_stubs/image_helper_stub.dart'
    if (dart.library.html) 'platform_stubs/image_helper_web.dart';
