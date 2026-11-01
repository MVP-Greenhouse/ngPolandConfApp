import 'package:flutter/foundation.dart';

/// Only the iOS app is set up for Sign in with Apple. The web app in Safari on
/// an iPhone also reports iOS, but there the plugin needs a Services ID.
bool supportsAppleSignIn({TargetPlatform? platform, bool isWeb = kIsWeb}) =>
    !isWeb && (platform ?? defaultTargetPlatform) == .iOS;
