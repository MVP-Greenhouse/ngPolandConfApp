import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/exceptions/auth_exception.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/delete_account.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/sign_out.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/watch_user_session.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/user_session_cubit.dart';

import '../../../../helpers/fakes.dart';

UserSessionCubit _cubit(FakeAuthenticationRepository authentication) =>
    UserSessionCubit(
      WatchUserSession(FakeUserSessionRepository()),
      SignOut(authentication),
      DeleteAccount(authentication, FakeUserRepository()),
    );

void main() {
  test('deleting the account reports no problem when it worked', () async {
    final cubit = _cubit(FakeAuthenticationRepository());

    expect(await cubit.deleteAccount(), isNull);
    await cubit.close();
  });

  test('deleting the account reports why it did not work', () async {
    final cubit = _cubit(
      FakeAuthenticationRepository()
        ..failure = const AuthException('Sign in again first.'),
    );

    expect(await cubit.deleteAccount(), 'Sign in again first.');
    await cubit.close();
  });
}
