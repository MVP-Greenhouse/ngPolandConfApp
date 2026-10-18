/// Resolves the Firebase email-link payload from an incoming app deep link.
///
/// Hosting-based Auth links often look like:
/// `https://PROJECT.firebaseapp.com/__/auth/links?link=<urlencoded action url>`
String? resolveMagicLinkEmailLink(Uri uri) {
  final nested = uri.queryParameters['link'];
  if (nested != null && nested.isNotEmpty && _looksLikeEmailLink(nested)) {
    return nested;
  }

  final asString = uri.toString();
  if (_looksLikeEmailLink(asString)) {
    return asString;
  }
  return null;
}

bool _looksLikeEmailLink(String value) {
  final uri = Uri.tryParse(value);
  if (uri == null) return false;

  if (_hasSignInOob(uri.queryParameters)) return true;
  if (value.contains('mode=signIn') && value.contains('oobCode=')) return true;

  // Nested Hosting wrapper: path is /__/auth/... and query carries the action URL.
  final nested = uri.queryParameters['link'];
  if (nested != null && nested.isNotEmpty) {
    final nestedUri = Uri.tryParse(nested);
    if (nestedUri != null && _hasSignInOob(nestedUri.queryParameters)) {
      return true;
    }
    if (nested.contains('mode=signIn') && nested.contains('oobCode=')) {
      return true;
    }
  }

  return false;
}

bool _hasSignInOob(Map<String, String> query) {
  final mode = query['mode']?.toLowerCase();
  return query.containsKey('oobCode') && mode == 'signin';
}
