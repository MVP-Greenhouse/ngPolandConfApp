import '../entities/user_profile.dart';

abstract interface class UserRepository {
  Future<UserProfile> ensureProfile({
    required String uid,
    required String displayName,
    required String email,
  });

  Stream<UserProfile?> watchProfile(String uid);
}
