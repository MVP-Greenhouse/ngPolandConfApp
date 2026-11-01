import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/delete_account.dart';

import '../../../../helpers/fakes.dart';

void main() {
  test('deletes the profile along with the account', () async {
    final authentication = FakeAuthenticationRepository();
    final users = FakeUserRepository();

    await DeleteAccount(authentication, users)();

    expect(users.deletedProfiles, [testAuthUser.uid]);
    expect(authentication.authUsers.value, isNull);
  });
}
