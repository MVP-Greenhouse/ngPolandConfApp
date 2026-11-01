import 'package:firebase_auth/firebase_auth.dart';

/// Firebase Email Link (magic link) settings.
///
/// Firebase Console / project checklist (manual):
/// 1. Authentication → Sign-in method → Email/Password → enable Email link.
/// 2. Authorized domains must include `ngpolandconfapp.web.app` /
///    `ngpolandconfapp.firebaseapp.com`.
/// 3. Do **not** try to activate Dynamic Links (onboarding is shut down).
///    Project must use Hosting mobile links:
///    `mobileLinksConfig.domain = HOSTING_DOMAIN` (Admin SDK, one-time).
/// 4. Android app in Firebase Console must have SHA-1 / SHA-256 fingerprints.
abstract final class MagicLinkConfig {
  static const continueUrl = 'https://ngpolandconfapp.web.app/auth';
  static const iosBundleId = 'com.mvpgreenhouse.ngPolandConfApp';
  static const androidPackageName = 'com.mvpgreenhouse.ng_poland_conf_app';
  static const androidMinimumVersion = '1';

  static ActionCodeSettings actionCodeSettings() => ActionCodeSettings(
    url: continueUrl,
    handleCodeInApp: true,
    iOSBundleId: iosBundleId,
    androidPackageName: androidPackageName,
    androidInstallApp: true,
    androidMinimumVersion: androidMinimumVersion,
    // Default Hosting domains (web.app / firebaseapp.com) are selected by the
    // project after mobileLinksConfig=HOSTING_DOMAIN. Do not set linkDomain
    // to those defaults; custom Hosting domains only.
  );
}
