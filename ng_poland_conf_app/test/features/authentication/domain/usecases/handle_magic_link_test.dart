import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/complete_magic_link.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/ensure_user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/handle_magic_link.dart';

import '../../../../helpers/fakes.dart';

void main() {
  late FakeAuthenticationRepository auth;
  late HandleMagicLink handleMagicLink;

  setUp(() {
    auth = FakeAuthenticationRepository();
    handleMagicLink = HandleMagicLink(
      auth,
      CompleteMagicLink(auth, EnsureUserProfile(FakeUserRepository())),
    );
  });

  tearDown(() => auth.dispose());

  test('ignores links that are not sign-in links', () async {
    final handled = await handleMagicLink(Uri.parse('https://example.com/'));

    expect(handled, isFalse);
    expect(auth.lastCompletedLink, isNull);
  });

  test('completes sign-in with the nested Hosting link', () async {
    const nested =
        'https://ngpolandconfapp.firebaseapp.com/__/auth/action?mode=signIn&oobCode=abc';
    auth.signInLinks = {nested};

    final handled = await handleMagicLink(
      Uri.parse(
        'https://ngpolandconfapp.firebaseapp.com/__/auth/links'
        '?link=${Uri.encodeComponent(nested)}',
      ),
    );

    expect(handled, isTrue);
    expect(auth.lastCompletedLink, nested);
  });
}
