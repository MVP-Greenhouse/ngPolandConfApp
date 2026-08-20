import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_role.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/repositories/user_repository.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/usecases/ensure_user_profile.dart';

class _FakeUserRepository implements UserRepository {
  UserProfile? stored;
  bool created = false;

  @override
  Future<UserProfile> ensureProfile({
    required String uid,
    required String displayName,
    required String email,
  }) async {
    if (stored != null) return stored!;
    created = true;
    stored = UserProfile(
      uid: uid,
      displayName: displayName,
      email: email,
      role: UserRole.user,
    );
    return stored!;
  }

  @override
  Stream<UserProfile?> watchProfile(String uid) => Stream.value(stored);
}

void main() {
  test('creates user role profile when missing', () async {
    final repo = _FakeUserRepository();
    final useCase = EnsureUserProfile(repo);
    final profile = await useCase(
      const EnsureUserProfileParams(
        uid: 'u1',
        displayName: 'Ada',
        email: 'ada@example.com',
      ),
    );
    expect(profile.role, UserRole.user);
    expect(repo.created, isTrue);
  });

  test('does not overwrite an existing admin profile', () async {
    final repo = _FakeUserRepository()
      ..stored = const UserProfile(
        uid: 'u1',
        displayName: 'Ada',
        email: 'ada@example.com',
        role: UserRole.admin,
      );
    final useCase = EnsureUserProfile(repo);
    final profile = await useCase(
      const EnsureUserProfileParams(
        uid: 'u1',
        displayName: 'Ada',
        email: 'ada@example.com',
      ),
    );
    expect(profile.role, UserRole.admin);
    expect(repo.created, isFalse);
  });
}
