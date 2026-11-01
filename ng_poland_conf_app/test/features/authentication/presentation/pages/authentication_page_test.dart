import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/pages/authentication_page.dart';

void main() {
  test('offers Sign in with Apple in the iOS app', () {
    expect(
      showsAppleSignIn(platform: TargetPlatform.iOS, isWeb: false),
      isTrue,
    );
  });

  test('hides Sign in with Apple on the web, even on an iPhone', () {
    expect(
      showsAppleSignIn(platform: TargetPlatform.iOS, isWeb: true),
      isFalse,
    );
  });

  test('hides Sign in with Apple on Android', () {
    expect(
      showsAppleSignIn(platform: TargetPlatform.android, isWeb: false),
      isFalse,
    );
  });
}
