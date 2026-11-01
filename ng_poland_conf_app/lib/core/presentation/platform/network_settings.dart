import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

const _networkSettingsChannel = MethodChannel('ngpoland/network_settings');

/// Opens the system network settings (Android) or the app settings (iOS).
///
/// Best effort: when the platform cannot open settings there is nothing more
/// useful to show, so failures are ignored.
Future<void> openNetworkSettings() async {
  if (kIsWeb) return;
  try {
    if (defaultTargetPlatform == .android) {
      await _networkSettingsChannel.invokeMethod<void>('open');
    } else {
      await launchUrl(Uri.parse('app-settings:'), mode: .externalApplication);
    }
  } on MissingPluginException {
    // Older Android builds without the native channel.
  } on PlatformException {
    // Settings screen unavailable on this device.
  }
}
