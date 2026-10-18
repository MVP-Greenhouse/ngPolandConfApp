import 'package:ng_poland_conf_app/core/constants/firebase_hosting.dart';
import 'package:ng_poland_conf_app/core/presentation/navigation/app_pages.dart';
import 'package:ng_poland_conf_app/core/utils/object_extensions.dart';

/// Firebase Hosting / Auth email links are opened as app deep links, but they
/// are not GoRouter routes. The router sends the user to `/auth` while the
/// magic link listener completes sign-in from the same URI.
bool isFirebaseAuthDeepLink(Uri uri) {
  if (uri.path.startsWith(firebaseAuthPathPrefix)) return true;
  if (uri.queryParameters.containsKey('oobCode') &&
      uri.queryParameters['mode']?.toLowerCase() == 'signin') {
    return true;
  }
  return switch (uri.queryParameters['link']) {
    final nested? when nested.isNotEmpty =>
      Uri.tryParse(nested)?.let(isFirebaseAuthDeepLink) ?? false,
    _ => false,
  };
}

/// Path (+ optional query) safe for in-app redirects after login.
///
/// Rejects absolute URLs, protocol-relative URLs, and `/auth` loops.
String? safeInternalRedirectPath(String? candidate) {
  if (candidate == null || candidate.isEmpty) return null;

  final value = candidate.trim();
  if (value.contains('://') ||
      value.startsWith('//') ||
      value.contains(r'\') ||
      value.contains('\n') ||
      value.contains('\r')) {
    return null;
  }
  if (!value.startsWith('/')) return null;

  final uri = Uri.tryParse(value);
  if (uri == null || uri.hasScheme || uri.host.isNotEmpty) return null;

  final path = uri.path;
  if (path.isEmpty || !path.startsWith('/')) return null;
  if (path == AppPaths.auth || path.startsWith('${AppPaths.auth}/')) {
    return null;
  }

  return uri.hasQuery ? '$path?${uri.query}' : path;
}

/// Location string suitable for [loginPath]'s `from`.
String internalLocationFromUri(Uri uri) {
  if (uri.hasScheme || uri.host.isNotEmpty) {
    return uri.hasQuery ? '${uri.path}?${uri.query}' : uri.path;
  }
  return uri.toString();
}

/// `/auth` route that returns to [from] after a successful sign-in.
String loginPath({String? from}) => switch (safeInternalRedirectPath(from)) {
  final safeFrom? => '${AppPaths.auth}?from=${Uri.encodeComponent(safeFrom)}',
  null => AppPaths.auth,
};
