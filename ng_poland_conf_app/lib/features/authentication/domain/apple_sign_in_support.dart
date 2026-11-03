import 'package:flutter/foundation.dart';

/// Only the iOS and macOS apps are set up for Sign in with Apple. The web app in
/// Safari also reports iOS or macOS, but there the plugin needs a Services ID.
bool supportsAppleSignIn({TargetPlatform? platform, bool isWeb = kIsWeb}) =>
    !isWeb &&
    const {
      TargetPlatform.iOS,
      TargetPlatform.macOS,
    }.contains(platform ?? defaultTargetPlatform);
