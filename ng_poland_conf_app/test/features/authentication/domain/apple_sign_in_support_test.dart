import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/apple_sign_in_support.dart';

void main() {
  test('Sign in with Apple works in the iOS app', () {
    expect(
      supportsAppleSignIn(platform: TargetPlatform.iOS, isWeb: false),
      isTrue,
    );
  });

  test('Sign in with Apple is off on the web, even on an iPhone', () {
    expect(
      supportsAppleSignIn(platform: TargetPlatform.iOS, isWeb: true),
      isFalse,
    );
  });

  test('Sign in with Apple is off on Android', () {
    expect(
      supportsAppleSignIn(platform: TargetPlatform.android, isWeb: false),
      isFalse,
    );
  });
}
