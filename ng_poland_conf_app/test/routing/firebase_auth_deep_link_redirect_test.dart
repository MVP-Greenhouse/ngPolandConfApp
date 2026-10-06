import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/logic/magic_link_uri.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/authentication_page.dart';
import 'package:ng_poland_conf_app/routing/routing.dart';

void main() {
  group('isFirebaseAuthDeepLink', () {
    test('detects Hosting /__/auth/links wrapper', () {
      final uri = Uri.parse(
        'https://ngpolandconfapp.firebaseapp.com/__/auth/links'
        '?link=https%3A%2F%2Fngpolandconfapp.firebaseapp.com%2F__%2Fauth%2Faction'
        '%3FapiKey%3Dx%26mode%3DsignIn%26oobCode%3Dabc'
        '%26continueUrl%3Dhttps%3A%2F%2Fngpolandconfapp.web.app%2Fauth%26lang%3Den',
      );

      expect(isFirebaseAuthDeepLink(uri), isTrue);
    });

    test('detects action URL with oobCode', () {
      final uri = Uri.parse(
        'https://ngpolandconfapp.firebaseapp.com/__/auth/action'
        '?apiKey=x&mode=signIn&oobCode=abc&continueUrl=https://ngpolandconfapp.web.app/auth',
      );

      expect(isFirebaseAuthDeepLink(uri), isTrue);
    });

    test('ignores normal app routes', () {
      expect(isFirebaseAuthDeepLink(Uri.parse('/auth')), isFalse);
      expect(isFirebaseAuthDeepLink(Uri.parse('/schedule')), isFalse);
    });
  });

  group('authRedirect for Firebase Auth links', () {
    test('redirects auth deep link to /auth', () {
      final uri = Uri.parse(
        'https://ngpolandconfapp.firebaseapp.com/__/auth/links?link=https://x',
      );

      expect(
        authRedirect(
          matchedLocation: uri.toString(),
          fullPath: uri.toString(),
          queryParameters: uri.queryParameters,
          isAuthenticated: false,
          uri: uri,
        ),
        AuthenticationPage.path,
      );
    });
  });

  group('resolveMagicLinkEmailLink', () {
    test('prefers nested link query param', () {
      const nested =
          'https://ngpolandconfapp.firebaseapp.com/__/auth/action?apiKey=x&mode=signIn&oobCode=abc';
      final uri = Uri.parse(
        'https://ngpolandconfapp.firebaseapp.com/__/auth/links'
        '?link=${Uri.encodeComponent(nested)}',
      );

      expect(resolveMagicLinkEmailLink(uri), nested);
    });

    test('ignores /__/auth/ path without sign-in oobCode', () {
      final uri = Uri.parse(
        'https://ngpolandconfapp.firebaseapp.com/__/auth/handler',
      );

      expect(resolveMagicLinkEmailLink(uri), isNull);
    });
  });
}
