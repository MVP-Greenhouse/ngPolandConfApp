import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/exceptions/auth_exception.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/send_magic_link.dart';

import '../../../../helpers/fakes.dart';

void main() {
  late FakeAuthenticationRepository auth;

  setUp(() => auth = FakeAuthenticationRepository());
  tearDown(() => auth.dispose());

  test('rejects an invalid email without calling the repository', () {
    expect(
      () => SendMagicLink(auth)(const SendMagicLinkParams(email: 'nope')),
      throwsA(
        isA<AuthException>().having(
          (error) => error.message,
          'message',
          'Enter a valid email address.',
        ),
      ),
    );
    expect(auth.lastSentEmail, isNull);
  });

  test('sends the trimmed address', () async {
    await SendMagicLink(auth)(const SendMagicLinkParams(email: ' a@b.pl '));

    expect(auth.lastSentEmail, 'a@b.pl');
  });
}
