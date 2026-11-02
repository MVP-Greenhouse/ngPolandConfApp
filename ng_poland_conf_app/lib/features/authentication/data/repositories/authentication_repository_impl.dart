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
import 'package:ng_poland_conf_app/features/authentication/domain/apple_sign_in_support.dart';
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
        final user = _userOf(
          await _auth.signInWithCredential(
            OAuthProvider('apple.com').credential(
              idToken: appleCredential.identityToken,
              rawNonce: rawNonce,
              accessToken: appleCredential.authorizationCode,
            ),
          ),
        );
        return _withAppleName(user, appleCredential);
      });

  @override
  Future<AuthUser> signInWithGoogle() => _signIn(
    'There was a problem signing in with Google.',
    () async => _userOf(
      await _auth.signInWithCredential(await _googleCredential()),
    ).toAuthUser(),
  );

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
      return _userOf(credential).toAuthUser();
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
    await _forgetGoogleSignIn();
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

  @override
  Future<void> deleteAccount({
    required Future<void> Function(String uid) deleteUserData,
  }) async {
    final user =
        _auth.currentUser ??
        (throw const AuthException('You are not signed in.'));
    final providers = {for (final info in user.providerData) info.providerId};
    try {
      // An account can be linked to both when they share an email. Outside the
      // iOS app there's no Apple flow, so its Apple access can't be revoked.
      if (providers.contains('apple.com') && supportsAppleSignIn()) {
        await _revokeAppleAccess(user);
      } else if (providers.contains('google.com')) {
        await _reauthenticateWithGoogle(user);
      } else if (!_signedInRecently(user)) {
        // Email links can't be re-sent mid-deletion, and deleting the data
        // first would leave an account without a profile.
        throw const AuthException(_signInAgainMessage);
      }
      await deleteUserData(user.uid);
      await user.delete();
      await _forgetGoogleSignIn();
    } on AuthException {
      rethrow;
    } catch (error, stackTrace) {
      if (error case FirebaseAuthException(code: 'requires-recent-login')) {
        throw const AuthException(_signInAgainMessage);
      }
      if (error case FirebaseAuthException(code: 'user-mismatch')) {
        throw const AuthException(_differentAccountMessage);
      }
      // Provider SDKs throw their own types (including user cancellation).
      _logger.w(
        'Account deletion failed',
        error: error,
        stackTrace: stackTrace,
      );
      throw const AuthException('There was a problem deleting your account.');
    }
  }

  static const _signInAgainMessage =
      'For your security, sign out and sign in again, then delete your '
      'account.';

  static const _differentAccountMessage =
      "You chose a different account than the one you're signed in with. "
      'Try again and choose that one.';

  /// Firebase deletes only accounts that signed in in the last 5 minutes.
  static bool _signedInRecently(User user) {
    final lastSignIn = user.metadata.lastSignInTime;
    return lastSignIn != null &&
        DateTime.now().difference(lastSignIn) < const Duration(minutes: 5);
  }

  /// Signs the user in again with Apple and revokes the app's Apple tokens,
  /// which Apple requires when an account is deleted.
  Future<void> _revokeAppleAccess(User user) async {
    final rawNonce = _appleNonce();
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: const [],
      nonce: _sha256ofString(rawNonce),
    );
    // The authorization code is single-use, so it goes only to the revocation.
    await user.reauthenticateWithCredential(
      OAuthProvider(
        'apple.com',
      ).credential(idToken: appleCredential.identityToken, rawNonce: rawNonce),
    );
    await _auth.revokeTokenWithAuthorizationCode(
      appleCredential.authorizationCode,
    );
  }

  /// Firebase creates a user for a Google account it doesn't know, even when
  /// it then rejects it, so a different account must never reach Firebase.
  Future<void> _reauthenticateWithGoogle(User user) async {
    final linked = user.providerData.firstWhere(
      (info) => info.providerId == 'google.com',
    );
    bool isLinked(GoogleSignInAccount account) =>
        account.id == linked.uid ||
        account.email.toLowerCase() == linked.email?.toLowerCase();

    // Google's picker can't be limited to one account, so the signed-in one
    // is tried first without it: iOS restores the last Google sign-in, and
    // Android picks the account already used in the app when there's one.
    final restored = await _restoreGoogleSignIn();
    final googleUser = restored != null && isLinked(restored)
        ? restored
        : await GoogleSignIn.instance.authenticate();
    if (!isLinked(googleUser)) {
      throw AuthException(
        "You chose ${googleUser.email}, but you're signed in with "
        "${linked.email ?? 'another account'}. Try again and choose that one.",
      );
    }
    await user.reauthenticateWithCredential(_credentialOf(googleUser));
  }

  /// Clears the Google sign-in the platform keeps for the app, so the next
  /// person signing in on the device isn't offered the previous account.
  /// Firebase is already signed out, so a failure here is only logged.
  Future<void> _forgetGoogleSignIn() async {
    try {
      await GoogleSignIn.instance.signOut();
    } catch (error, stackTrace) {
      _logger.w(
        'Clearing the Google sign-in failed',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Returns the Google account the platform gives without the full picker,
  /// or null when there's none and the picker has to be shown.
  Future<GoogleSignInAccount?> _restoreGoogleSignIn() async {
    try {
      return await GoogleSignIn.instance.attemptLightweightAuthentication(
        reportAllExceptions: true,
      );
    } on GoogleSignInException catch (error, stackTrace) {
      // Android may show a bottom sheet here; closing it cancels the deletion
      // rather than opening a second picker.
      if (error.code == GoogleSignInExceptionCode.canceled) rethrow;
      _logger.w(
        'Account deletion: restoring the Google sign-in failed',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<AuthCredential> _googleCredential() async =>
      _credentialOf(await GoogleSignIn.instance.authenticate());

  AuthCredential _credentialOf(GoogleSignInAccount googleUser) =>
      GoogleAuthProvider.credential(idToken: googleUser.authentication.idToken);

  /// Runs a provider flow that ends signed in to Firebase.
  Future<AuthUser> _signIn(
    String failureMessage,
    Future<AuthUser> Function() signIn,
  ) async {
    try {
      return await signIn();
    } on AuthException {
      rethrow;
    } catch (error, stackTrace) {
      // Provider SDKs throw their own types (including user cancellation).
      _logger.w('Social sign-in failed', error: error, stackTrace: stackTrace);
      throw AuthException(failureMessage);
    }
  }

  /// Apple shares the user's name only on the first sign-in and Firebase
  /// doesn't keep it, so it's saved on the Firebase user here.
  Future<AuthUser> _withAppleName(
    User user,
    AuthorizationCredentialAppleID appleCredential,
  ) async {
    final name = [
      appleCredential.givenName,
      appleCredential.familyName,
    ].nonNulls.join(' ').trim();
    if (name.isEmpty || (user.displayName ?? '').isNotEmpty) {
      return user.toAuthUser();
    }
    try {
      await user.updateDisplayName(name);
    } on FirebaseAuthException catch (error, stackTrace) {
      // The returned user still carries the name, so the profile gets it.
      _logger.w(
        'Apple sign-in: saving the name failed',
        error: error,
        stackTrace: stackTrace,
      );
    }
    return user.toAuthUser(displayName: name);
  }

  User _userOf(UserCredential credential) =>
      credential.user ??
      (throw const AuthException('Sign-in did not return a user.'));
}

extension on User {
  AuthUser toAuthUser({String? displayName}) => AuthUser(
    uid: uid,
    displayName: displayName ?? this.displayName ?? '',
    email: email ?? '',
  );
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
