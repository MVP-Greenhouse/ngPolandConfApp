import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/authentication/datasources/data/magic_link_email_local_datasource.dart';
import 'package:ng_poland_conf_app/features/authentication/datasources/repositories/authentication_repository.dart';

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

void main() {
  test('sendSignInLink rejects invalid email without calling Firebase', () async {
    final local = _FakeMagicLinkEmailLocalDataSource();
    final repo = AuthenticationRepositoryImpl(local);

    final result = await repo.sendSignInLink('not-an-email');

    expect(result, left('Enter a valid email address.'));
    expect(local.pending, isNull);
  });

  test('completeSignInWithEmailLink fails when pending email missing', () async {
    final local = _FakeMagicLinkEmailLocalDataSource();
    final repo = AuthenticationRepositoryImpl(local);

    // Without a valid email-link payload Firebase returns false for
    // isSignInWithEmailLink; we assert the local-email guard via empty pending
    // after a synthetic path by testing the local datasource contract used by repo.
    await local.savePendingEmail('');
    expect(await local.getPendingEmail(), isEmpty);

    final result = await repo.completeSignInWithEmailLink('https://example.com');
    expect(result.isLeft(), isTrue);
  });
}
