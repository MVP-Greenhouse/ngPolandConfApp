import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/authentication/data/datasources/magic_link_email_local_datasource.dart';
import 'package:ng_poland_conf_app/features/authentication/data/repositories/authentication_repository_impl.dart';

import '../../../../helpers/fakes.dart';

/// Channel the sign_in_with_apple plugin uses on iOS and macOS.
const _appleChannel = MethodChannel(
  'com.aboutyou.dart_packages.sign_in_with_apple',
);

/// Answers the Apple sheet like iOS does. Apple shares the name only on the
/// first sign-in.
void _appleReturns({String? givenName, String? familyName}) {
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
        _appleChannel,
        (_) async => {
          'type': 'appleid',
          'authorizationCode': 'code',
          'identityToken': 'token',
          'givenName': givenName,
          'familyName': familyName,
        },
      );
}

class _FakeUser implements User {
  _FakeUser({this.displayName, this.updateError});

  @override
  final String? displayName;

  /// When set, [updateDisplayName] fails with it.
  final Object? updateError;
  String? savedDisplayName;

  @override
  String get uid => 'u1';

  @override
  String? get email => 'ada@privaterelay.appleid.com';

  @override
  Future<void> updateDisplayName(String? displayName) async {
    if (updateError case final error?) throw error;
    savedDisplayName = displayName;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeUserCredential implements UserCredential {
  _FakeUserCredential(this.user);

  @override
  final User user;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Only [signInWithCredential] is used by the code under test.
class _FakeFirebaseAuth implements FirebaseAuth {
  _FakeFirebaseAuth(this.user);

  final User user;

  @override
  Future<UserCredential> signInWithCredential(
    AuthCredential credential,
  ) async => _FakeUserCredential(user);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Not used by Apple sign-in.
class _UnusedMagicLinkEmailLocalDataSource
    implements MagicLinkEmailLocalDataSource {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

AuthenticationRepositoryImpl _repository(User user) =>
    AuthenticationRepositoryImpl(
      _UnusedMagicLinkEmailLocalDataSource(),
      _FakeFirebaseAuth(user),
      silentLogger,
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(
    () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_appleChannel, null),
  );

  test('saves the name Apple shares on the first sign-in', () async {
    _appleReturns(givenName: 'Ada', familyName: 'Lovelace');
    final user = _FakeUser();

    final authUser = await _repository(user).signInWithApple();

    expect(authUser.displayName, 'Ada Lovelace');
    expect(user.savedDisplayName, 'Ada Lovelace');
  });

  test('keeps the saved name on later sign-ins', () async {
    _appleReturns();
    final user = _FakeUser(displayName: 'Ada Lovelace');

    final authUser = await _repository(user).signInWithApple();

    expect(authUser.displayName, 'Ada Lovelace');
    expect(user.savedDisplayName, isNull);
  });

  test('still signs in when saving the name fails', () async {
    _appleReturns(givenName: 'Ada', familyName: 'Lovelace');
    final user = _FakeUser(
      updateError: FirebaseAuthException(code: 'network-request-failed'),
    );

    final authUser = await _repository(user).signInWithApple();

    expect(authUser.displayName, 'Ada Lovelace');
  });
}
