import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_role.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/repositories/user_repository.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/usecases/ensure_user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/user_session_cubit.dart';

class _SessionRepo implements UserRepository {
  _SessionRepo({
    this.ensureThrows = false,
    this.watchThrows = false,
    this.watchStreamError = false,
    this.profile,
  });

  final bool ensureThrows;
  final bool watchThrows;
  final bool watchStreamError;
  final UserProfile? profile;
  var watchAttached = false;

  @override
  Future<UserProfile> ensureProfile({
    required String uid,
    required String displayName,
    required String email,
  }) async {
    if (ensureThrows) throw Exception('ensure failed');
    return profile!;
  }

  @override
  Stream<UserProfile?> watchProfile(String uid) {
    watchAttached = true;
    if (watchThrows) throw Exception('watch failed');
    if (watchStreamError) return Stream.error(Exception('snapshot failed'));
    return Stream.value(profile);
  }
}

UserSessionCubit _cubit(_SessionRepo repo) {
  return UserSessionCubit(
    EnsureUserProfile(repo),
    repo,
    authStateChanges: const Stream.empty(),
  );
}

void main() {
  const profile = UserProfile(
    uid: 'u1',
    displayName: 'Ada',
    email: 'ada@example.com',
    role: UserRole.user,
  );

  test(
    'attaches watchProfile after ensure failure and authenticates',
    () async {
      final repo = _SessionRepo(ensureThrows: true, profile: profile);
      final cubit = _cubit(repo);

      await cubit.onAuthChanged(
        uid: 'u1',
        displayName: 'Ada',
        email: 'ada@example.com',
      );
      await Future<void>.delayed(Duration.zero);

      expect(repo.watchAttached, isTrue);
      expect(cubit.state, const UserSessionState.authenticated(profile));
      await cubit.close();
    },
  );

  test(
    'emits unauthenticated when ensure and watchProfile both fail',
    () async {
      final repo = _SessionRepo(ensureThrows: true, watchThrows: true);
      final cubit = _cubit(repo);

      await cubit.onAuthChanged(
        uid: 'u1',
        displayName: 'Ada',
        email: 'ada@example.com',
      );

      expect(cubit.state, const UserSessionState.unauthenticated());
      await cubit.close();
    },
  );

  test('emits unauthenticated when watchProfile stream errors', () async {
    final repo = _SessionRepo(ensureThrows: true, watchStreamError: true);
    final cubit = _cubit(repo);

    await cubit.onAuthChanged(
      uid: 'u1',
      displayName: 'Ada',
      email: 'ada@example.com',
    );
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state, const UserSessionState.unauthenticated());
    await cubit.close();
  });
}
