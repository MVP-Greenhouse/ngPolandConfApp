import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/authentication/data/repositories/user_session_repository_impl.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_session.dart';

import '../../../../helpers/fakes.dart';

void main() {
  late FakeAuthenticationRepository auth;

  setUp(() => auth = FakeAuthenticationRepository());
  tearDown(() => auth.dispose());

  Future<UserSession> sessionAfterSignIn(FakeUserRepository users) async {
    final repository = UserSessionRepositoryImpl(auth, users, silentLogger);
    final sessions = repository.watch();
    auth.authUsers.add(testAuthUser);
    final session = await sessions.firstWhere(
      (session) => session is! SessionLoading,
    );
    await repository.dispose();
    return session;
  }

  test('starts signed out without an auth user', () async {
    final repository = UserSessionRepositoryImpl(
      auth,
      FakeUserRepository(),
      silentLogger,
    );

    await expectLater(
      repository.watch(),
      emitsThrough(const UserSession.signedOut()),
    );
    await repository.dispose();
  });

  test('watches the profile even when ensuring it failed', () async {
    final users = FakeUserRepository(
      profile: userProfile,
      ensureError: Exception('ensure failed'),
    );

    final session = await sessionAfterSignIn(users);

    expect(users.watchAttached, isTrue);
    expect(session, const UserSession.signedIn(userProfile));
  });

  test('signs out when ensure and watching the profile both fail', () async {
    final session = await sessionAfterSignIn(
      FakeUserRepository(
        ensureError: Exception('ensure failed'),
        watchError: Exception('watch failed'),
      ),
    );

    expect(session, const UserSession.signedOut());
  });

  test('signs out when the profile stream errors', () async {
    final session = await sessionAfterSignIn(
      FakeUserRepository(
        ensureError: Exception('ensure failed'),
        watchStreamError: true,
      ),
    );

    expect(session, const UserSession.signedOut());
  });
}
