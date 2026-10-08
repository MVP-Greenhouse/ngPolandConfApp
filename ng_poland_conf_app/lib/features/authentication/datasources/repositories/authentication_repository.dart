import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/authentication/datasources/data/magic_link_email_local_datasource.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/constants/magic_link_auth_constants.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/repositories/authentication_repository.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

@Singleton(as: AuthenticationRepository)
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  const AuthenticationRepositoryImpl(this._magicLinkEmailLocalDataSource);

  final MagicLinkEmailLocalDataSource _magicLinkEmailLocalDataSource;

  FirebaseAuth get _auth => FirebaseAuth.instance;

  @override
  Future<Either<String, String>> signInWithApple() async {
    try {
      final rawNonce = _appleNonce();
      final AuthorizationCredentialAppleID appleCredential =
          await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
            nonce: _sha256ofString(rawNonce),
          );
      final AuthCredential authCredential = OAuthProvider('apple.com')
          .credential(
            idToken: appleCredential.identityToken,
            rawNonce: rawNonce,
            accessToken: appleCredential.authorizationCode,
          );
      await _auth.signInWithCredential(authCredential);
      return right('Signed in');
    } catch (_) {
      return left('There was a problem signing in with Apple.');
    }
  }

  @override
  Future<Either<String, String>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
      return right('Signed in');
    } catch (_) {
      return left('There was a problem signing in with Google.');
    }
  }

  @override
  Future<Either<String, String>> sendSignInLink(String email) async {
    final trimmed = email.trim();
    if (trimmed.isEmpty || !trimmed.contains('@')) {
      return left('Enter a valid email address.');
    }

    try {
      await _auth.sendSignInLinkToEmail(
        email: trimmed,
        actionCodeSettings: MagicLinkAuthConstants.actionCodeSettings(),
      );
      await _magicLinkEmailLocalDataSource.savePendingEmail(trimmed);
      return right('Sign-in link sent');
    } on FirebaseAuthException catch (error) {
      final code = error.code.toLowerCase();
      final message = error.message ?? '';
      if (code.contains('dynamic') ||
          message.contains('FDL') ||
          message.contains('Dynamic Links')) {
        return left(
          'Magic link requires Hosting links (not Dynamic Links). '
          'Set mobileLinksConfig.domain = HOSTING_DOMAIN in the Firebase project.',
        );
      }
      return left('There was a problem sending the sign-in link.');
    } catch (_) {
      return left('There was a problem sending the sign-in link.');
    }
  }

  @override
  Future<Either<String, String>> completeSignInWithEmailLink(
    String emailLink,
  ) async {
    try {
      if (!_auth.isSignInWithEmailLink(emailLink)) {
        return left('The sign-in link is invalid.');
      }

      final email = await _magicLinkEmailLocalDataSource.getPendingEmail();
      if (email == null || email.isEmpty) {
        return left('No saved email. Send the link again on this device.');
      }

      await _auth.signInWithEmailLink(email: email, emailLink: emailLink);
      await _magicLinkEmailLocalDataSource.clearPendingEmail();
      return right('Signed in');
    } catch (_) {
      return left('There was a problem signing in with the email link.');
    }
  }
}

String _appleNonce([int length = 32]) {
  const charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(
    length,
    (_) => charset[random.nextInt(charset.length)],
  ).join();
}

String _sha256ofString(String input) =>
    sha256.convert(utf8.encode(input)).toString();
