import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/auth_user.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_role.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/repositories/user_repository.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/ensure_user_profile.dart';

class _FakeUserRepository implements UserRepository {
  UserProfile? stored;
  bool created = false;

  @override
  Future<UserProfile> ensureProfile({
    required String uid,
    required String displayName,
    required String email,
  }) async {
    if (stored case final existing?) return existing;
    created = true;
    return stored = UserProfile(
      uid: uid,
      displayName: displayName,
      email: email,
      role: UserRole.user,
    );
  }

  @override
  Stream<UserProfile?> watchProfile(String uid) => Stream.value(stored);
}

void main() {
  test('creates user role profile when missing', () async {
    final repo = _FakeUserRepository();
    final useCase = EnsureUserProfile(repo);
    final profile = await useCase(
      const AuthUser(uid: 'u1', displayName: 'Ada', email: 'ada@example.com'),
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
      const AuthUser(uid: 'u1', displayName: 'Ada', email: 'ada@example.com'),
    );
    expect(profile.role, UserRole.admin);
    expect(repo.created, isFalse);
  });
}
