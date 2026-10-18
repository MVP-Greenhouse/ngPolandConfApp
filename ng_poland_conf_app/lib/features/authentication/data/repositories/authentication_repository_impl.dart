import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:ng_poland_conf_app/features/authentication/data/datasources/firebase_auth_config.dart';
import 'package:ng_poland_conf_app/features/authentication/data/datasources/magic_link_email_local_datasource.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/auth_user.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/exceptions/auth_exception.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

@Singleton(as: AuthenticationRepository)
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  const AuthenticationRepositoryImpl(
    this._magicLinkEmailLocalDataSource,
    this._auth,
    this._logger,
  );

  final MagicLinkEmailLocalDataSource _magicLinkEmailLocalDataSource;
  final FirebaseAuth _auth;
  final Logger _logger;

  @override
  Stream<AuthUser?> watchAuthUser() =>
      _auth.authStateChanges().map((user) => user?.toAuthUser());

  @override
  bool isSignInLink(String link) => _auth.isSignInWithEmailLink(link);

  @override
  Future<AuthUser> signInWithApple() =>
      _signIn('There was a problem signing in with Apple.', () async {
        final rawNonce = _appleNonce();
        final appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          nonce: _sha256ofString(rawNonce),
        );
        return OAuthProvider('apple.com').credential(
          idToken: appleCredential.identityToken,
          rawNonce: rawNonce,
          accessToken: appleCredential.authorizationCode,
        );
      });

  @override
  Future<AuthUser> signInWithGoogle() =>
      _signIn('There was a problem signing in with Google.', () async {
        final googleUser = await GoogleSignIn.instance.authenticate();
        return GoogleAuthProvider.credential(
          idToken: googleUser.authentication.idToken,
        );
      });

  @override
  Future<void> sendSignInLink(String email) async {
    try {
      await _auth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: MagicLinkConfig.actionCodeSettings(),
      );
    } on FirebaseAuthException catch (error, stackTrace) {
      _logger.w(
        'Magic link: send failed',
        error: error,
        stackTrace: stackTrace,
      );
      final message = error.message ?? '';
      if (error.code.toLowerCase().contains('dynamic') ||
          message.contains('FDL') ||
          message.contains('Dynamic Links')) {
        throw const AuthException(
          'Magic link requires Hosting links (not Dynamic Links). '
          'Set mobileLinksConfig.domain = HOSTING_DOMAIN in the Firebase project.',
        );
      }
      throw const AuthException(
        'There was a problem sending the sign-in link.',
      );
    }
    await _magicLinkEmailLocalDataSource.savePendingEmail(email);
  }

  @override
  Future<AuthUser> completeSignInWithEmailLink(String emailLink) async {
    if (!isSignInLink(emailLink)) {
      throw const AuthException('The sign-in link is invalid.');
    }
    final email = await _magicLinkEmailLocalDataSource.getPendingEmail();
    if (email == null || email.isEmpty) {
      throw const AuthException(
        'No saved email. Send the link again on this device.',
      );
    }

    try {
      final credential = await _auth.signInWithEmailLink(
        email: email,
        emailLink: emailLink,
      );
      await _magicLinkEmailLocalDataSource.clearPendingEmail();
      return _userOf(credential);
    } on FirebaseAuthException catch (error, stackTrace) {
      _logger.w(
        'Magic link: sign-in failed',
        error: error,
        stackTrace: stackTrace,
      );
      throw const AuthException(
        'There was a problem signing in with the email link.',
      );
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
    try {
      await FirebaseFirestore.instance.clearPersistence();
    } on FirebaseException catch (error, stackTrace) {
      // `failed-precondition` means Firestore is still in use, which is
      // expected right after sign-out; anything else is worth logging.
      if (error.code != 'failed-precondition') {
        _logger.w(
          'Sign out: clearing Firestore cache failed',
          error: error,
          stackTrace: stackTrace,
        );
      }
    }
  }

  /// Runs a provider flow and signs in to Firebase with its credential.
  Future<AuthUser> _signIn(
    String failureMessage,
    Future<AuthCredential> Function() credential,
  ) async {
    try {
      return _userOf(await _auth.signInWithCredential(await credential()));
    } on AuthException {
      rethrow;
    } catch (error, stackTrace) {
      // Provider SDKs throw their own types (including user cancellation).
      _logger.w('Social sign-in failed', error: error, stackTrace: stackTrace);
      throw AuthException(failureMessage);
    }
  }

  AuthUser _userOf(UserCredential credential) =>
      credential.user?.toAuthUser() ??
      (throw const AuthException('Sign-in did not return a user.'));
}

extension on User {
  AuthUser toAuthUser() =>
      AuthUser(uid: uid, displayName: displayName ?? '', email: email ?? '');
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
