import 'package:ng_poland_conf_app/features/authentication/domain/entities/auth_user.dart';

/// Sign-in operations. Failures are reported as `AuthException`.
abstract interface class AuthenticationRepository {
  Stream<AuthUser?> watchAuthUser();

  /// Whether [link] is a Firebase email sign-in link.
  bool isSignInLink(String link);

  Future<AuthUser> signInWithGoogle();

  Future<AuthUser> signInWithApple();

  Future<void> sendSignInLink(String email);

  Future<AuthUser> completeSignInWithEmailLink(String emailLink);

  /// Signs out and clears locally cached user data.
  Future<void> signOut();

  /// Deletes the signed-in account. The user first signs in again with their
  /// provider, then [deleteUserData] removes their data while still signed in.
  Future<void> deleteAccount({
    required Future<void> Function(String uid) deleteUserData,
  });
}
