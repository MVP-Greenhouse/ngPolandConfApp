import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_profile.dart';

abstract interface class UserRepository {
  /// Creates the profile document when missing.
  ///
  /// Throws `ProfileSyncException` when it cannot be read or written.
  Future<UserProfile> ensureProfile({
    required String uid,
    required String displayName,
    required String email,
  });

  Stream<UserProfile?> watchProfile(String uid);

  /// Throws `AuthException` when the profile cannot be deleted.
  Future<void> deleteProfile(String uid);
}
