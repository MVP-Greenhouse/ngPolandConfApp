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
}
