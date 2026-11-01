import 'package:ng_poland_conf_app/core/constants/firebase_hosting.dart';
import 'package:ng_poland_conf_app/core/presentation/navigation/app_pages.dart';
import 'package:ng_poland_conf_app/core/presentation/navigation/redirect_paths.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_session.dart';

/// Keeps non-admins out of `/admin`; waits while the session is loading.
String? adminGuardRedirect({
  required String matchedLocation,
  required UserSession session,
}) {
  if (!matchedLocation.startsWith(AppPaths.admin)) return null;
  return switch (session) {
    SessionLoading() => null,
    _ when session.isAdmin => null,
    _ => Pages.home.path,
  };
}

/// Sends Firebase auth links to `/auth` and signed-in users away from it.
String? authRedirect({
  required String matchedLocation,
  required String? fullPath,
  required Map<String, String> queryParameters,
  required bool isAuthenticated,
  Uri? uri,
}) {
  if (uri != null && isFirebaseAuthDeepLink(uri)) return AppPaths.auth;

  // GoRouter may pass the full https://… Auth URL as matchedLocation.
  if (matchedLocation.contains(firebaseAuthPathPrefix) ||
      (fullPath?.contains(firebaseAuthPathPrefix) ?? false)) {
    return AppPaths.auth;
  }

  if (!isAuthenticated) return null;

  final onAuth =
      matchedLocation == AppPaths.auth ||
      (fullPath?.contains(AppPaths.auth) ?? false);
  if (!onAuth) return null;

  return safeInternalRedirectPath(queryParameters['from']) ?? Pages.home.path;
}
