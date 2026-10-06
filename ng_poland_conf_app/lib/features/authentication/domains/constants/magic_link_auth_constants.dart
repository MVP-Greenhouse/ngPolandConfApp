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
class MagicLinkAuthConstants {
  const MagicLinkAuthConstants._();

  static const String continueUrl = 'https://ngpolandconfapp.web.app/auth';
  static const String iosBundleId = 'com.mvpgreenhouse.ngPolandConfApp';
  static const String androidPackageName = 'com.mvpgreenhouse.ng_poland_conf_app';
  static const String androidMinimumVersion = '1';

  static const String hostingHost = 'ngpolandconfapp.web.app';
  static const String firebaseAuthHost = 'ngpolandconfapp.firebaseapp.com';

  /// Hosting-based auth links use `/__/auth/links` (not Dynamic Links).
  static const String authLinksPathPrefix = '/__/auth/links';

  static ActionCodeSettings actionCodeSettings() => ActionCodeSettings(
        url: continueUrl,
        handleCodeInApp: true,
        iOSBundleId: iosBundleId,
        androidPackageName: androidPackageName,
        androidInstallApp: true,
        androidMinimumVersion: androidMinimumVersion,
        // Default Hosting domains (web.app / firebaseapp.com) are selected by
        // the project after mobileLinksConfig=HOSTING_DOMAIN. Do not set
        // linkDomain to those defaults; custom Hosting domains only.
      );
}
