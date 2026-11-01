import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/authentication/data/datasources/magic_link_email_local_datasource.dart';
import 'package:ng_poland_conf_app/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/exceptions/auth_exception.dart';

import '../../../../helpers/fakes.dart';

class _FakeMagicLinkEmailLocalDataSource
    implements MagicLinkEmailLocalDataSource {
  String? pending;

  @override
  Future<void> clearPendingEmail() async => pending = null;

  @override
  Future<String?> getPendingEmail() async => pending;

  @override
  Future<void> savePendingEmail(String email) async => pending = email;
}

/// Only [isSignInWithEmailLink] is used by the code under test.
class _FakeFirebaseAuth implements FirebaseAuth {
  _FakeFirebaseAuth({this.acceptedLink});

  final String? acceptedLink;

  @override
  bool isSignInWithEmailLink(String emailLink) => emailLink == acceptedLink;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Matcher _authError(String message) => throwsA(
  isA<AuthException>().having((error) => error.message, 'message', message),
);

void main() {
  test('rejects links that are not Firebase sign-in links', () async {
    final repository = AuthenticationRepositoryImpl(
      _FakeMagicLinkEmailLocalDataSource(),
      _FakeFirebaseAuth(),
      silentLogger,
    );

    await expectLater(
      repository.completeSignInWithEmailLink('https://example.com'),
      _authError('The sign-in link is invalid.'),
    );
  });

  test(
    'asks to resend the link when no email was saved on this device',
    () async {
      const link = 'https://example.com/__/auth/action?oobCode=abc';
      final local = _FakeMagicLinkEmailLocalDataSource()..pending = '';
      final repository = AuthenticationRepositoryImpl(
        local,
        _FakeFirebaseAuth(acceptedLink: link),
        silentLogger,
      );

      await expectLater(
        repository.completeSignInWithEmailLink(link),
        _authError('No saved email. Send the link again on this device.'),
      );
    },
  );
}
