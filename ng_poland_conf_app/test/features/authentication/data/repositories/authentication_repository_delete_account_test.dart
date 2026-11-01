import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:ng_poland_conf_app/features/authentication/data/datasources/magic_link_email_local_datasource.dart';
import 'package:ng_poland_conf_app/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/exceptions/auth_exception.dart';

import '../../../../helpers/fakes.dart';

/// Channel the sign_in_with_apple plugin uses on iOS and macOS.
const _appleChannel = MethodChannel(
  'com.aboutyou.dart_packages.sign_in_with_apple',
);

void _appleReturns({required String authorizationCode}) {
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
        _appleChannel,
        (_) async => {
          'type': 'appleid',
          'authorizationCode': authorizationCode,
          'identityToken': 'token',
        },
      );
}

/// Stands in for the native SDK behind `GoogleSignIn.instance`.
class _FakeGoogleSignIn extends GoogleSignInPlatform {
  _FakeGoogleSignIn({this.error});

  /// When set, [authenticate] fails with it.
  final GoogleSignInException? error;

  @override
  Future<AuthenticationResults> authenticate(
    AuthenticateParameters params,
  ) async {
    if (error case final error?) throw error;
    return const AuthenticationResults(
      user: GoogleSignInUserData(email: 'user@example.com', id: 'google-id'),
      authenticationTokens: AuthenticationTokenData(idToken: 'google-token'),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeUserInfo implements UserInfo {
  _FakeUserInfo(this.providerId);

  @override
  final String providerId;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeUserMetadata implements UserMetadata {
  _FakeUserMetadata(this.lastSignInTime);

  @override
  final DateTime lastSignInTime;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeUserCredential implements UserCredential {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Records each deletion step in [steps].
class _FakeUser implements User {
  _FakeUser({
    required List<String> providers,
    required DateTime lastSignIn,
    required this.steps,
    this.reauthenticateError,
  }) : providerData = [for (final id in providers) _FakeUserInfo(id)],
       metadata = _FakeUserMetadata(lastSignIn);

  final List<String> steps;

  /// When set, [reauthenticateWithCredential] fails with it.
  final Object? reauthenticateError;

  /// The credential the user signed in again with.
  AuthCredential? reauthenticatedWith;

  @override
  final List<UserInfo> providerData;

  @override
  final UserMetadata metadata;

  @override
  String get uid => 'u1';

  @override
  Future<UserCredential> reauthenticateWithCredential(
    AuthCredential credential,
  ) async {
    if (reauthenticateError case final error?) throw error;
    reauthenticatedWith = credential;
    steps.add('sign in again with ${credential.providerId}');
    return _FakeUserCredential();
  }

  @override
  Future<void> delete() async => steps.add('delete account');

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeFirebaseAuth implements FirebaseAuth {
  _FakeFirebaseAuth(this._user, {this.revokeError});

  final _FakeUser _user;

  /// When set, [revokeTokenWithAuthorizationCode] fails with it.
  final Object? revokeError;

  @override
  User get currentUser => _user;

  @override
  Future<void> revokeTokenWithAuthorizationCode(
    String authorizationCode,
  ) async {
    if (revokeError case final error?) throw error;
    _user.steps.add('revoke Apple access with $authorizationCode');
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Not used by account deletion.
class _UnusedMagicLinkEmailLocalDataSource
    implements MagicLinkEmailLocalDataSource {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

AuthenticationRepositoryImpl _repository(
  _FakeUser user, {
  Object? revokeError,
}) => AuthenticationRepositoryImpl(
  _UnusedMagicLinkEmailLocalDataSource(),
  _FakeFirebaseAuth(user, revokeError: revokeError),
  silentLogger,
);

final _deletionFailed = throwsA(
  isA<AuthException>().having(
    (error) => error.message,
    'message',
    'There was a problem deleting your account.',
  ),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final anHourAgo = DateTime.now().subtract(const Duration(hours: 1));
  final aMinuteAgo = DateTime.now().subtract(const Duration(minutes: 1));

  setUp(() => debugDefaultTargetPlatformOverride = TargetPlatform.iOS);

  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_appleChannel, null);
  });

  final googleSignIn = GoogleSignInPlatform.instance;
  tearDown(() => GoogleSignInPlatform.instance = googleSignIn);

  test('Apple users sign in again and lose Apple access before the account '
      'and its data are deleted', () async {
    _appleReturns(authorizationCode: 'fresh-code');
    final user = _FakeUser(
      providers: const ['apple.com'],
      lastSignIn: anHourAgo,
      steps: [],
    );

    await _repository(user).deleteAccount(
      deleteUserData: (uid) async => user.steps.add('delete data of $uid'),
    );

    expect(user.steps, [
      'sign in again with apple.com',
      'revoke Apple access with fresh-code',
      'delete data of u1',
      'delete account',
    ]);
  });

  test('keeps the account and its data when Apple access cannot be '
      'revoked', () async {
    _appleReturns(authorizationCode: 'fresh-code');
    final user = _FakeUser(
      providers: const ['apple.com'],
      lastSignIn: anHourAgo,
      steps: [],
    );

    await expectLater(
      _repository(
        user,
        revokeError: FirebaseAuthException(code: 'invalid-credential'),
      ).deleteAccount(
        deleteUserData: (uid) async => user.steps.add('delete data of $uid'),
      ),
      _deletionFailed,
    );
    expect(user.steps, ['sign in again with apple.com']);
  });

  test('on Android an account linked to Apple and Google goes through '
      'Google, because the app has no Apple sign-in there', () async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    GoogleSignInPlatform.instance = _FakeGoogleSignIn();
    final user = _FakeUser(
      providers: const ['google.com', 'apple.com'],
      lastSignIn: anHourAgo,
      steps: [],
    );

    await _repository(user).deleteAccount(
      deleteUserData: (uid) async => user.steps.add('delete data of $uid'),
    );

    expect(user.steps, [
      'sign in again with google.com',
      'delete data of u1',
      'delete account',
    ]);
  });

  test('on iOS an account linked to Apple and Google still revokes Apple '
      'access, which Apple requires', () async {
    _appleReturns(authorizationCode: 'fresh-code');
    final user = _FakeUser(
      providers: const ['google.com', 'apple.com'],
      lastSignIn: anHourAgo,
      steps: [],
    );

    await _repository(user).deleteAccount(
      deleteUserData: (uid) async => user.steps.add('delete data of $uid'),
    );

    expect(user.steps, [
      'sign in again with apple.com',
      'revoke Apple access with fresh-code',
      'delete data of u1',
      'delete account',
    ]);
  });

  test('Google users sign in again with the picked account before the '
      'account and its data are deleted', () async {
    GoogleSignInPlatform.instance = _FakeGoogleSignIn();
    final user = _FakeUser(
      providers: const ['google.com'],
      lastSignIn: anHourAgo,
      steps: [],
    );

    await _repository(user).deleteAccount(
      deleteUserData: (uid) async => user.steps.add('delete data of $uid'),
    );

    expect(user.steps, [
      'sign in again with google.com',
      'delete data of u1',
      'delete account',
    ]);
    expect(
      user.reauthenticatedWith,
      isA<OAuthCredential>().having(
        (credential) => credential.idToken,
        'idToken',
        'google-token',
      ),
    );
  });

  test('keeps the account and its data when the Google account picker is '
      'closed', () async {
    GoogleSignInPlatform.instance = _FakeGoogleSignIn(
      error: const GoogleSignInException(code: .canceled),
    );
    final user = _FakeUser(
      providers: const ['google.com'],
      lastSignIn: anHourAgo,
      steps: [],
    );

    await expectLater(
      _repository(user).deleteAccount(
        deleteUserData: (uid) async => user.steps.add('delete data of $uid'),
      ),
      _deletionFailed,
    );
    expect(user.steps, isEmpty);
  });

  test('keeps the account and its data when a different Google account is '
      'picked', () async {
    GoogleSignInPlatform.instance = _FakeGoogleSignIn();
    final user = _FakeUser(
      providers: const ['google.com'],
      lastSignIn: anHourAgo,
      steps: [],
      reauthenticateError: FirebaseAuthException(code: 'user-mismatch'),
    );

    await expectLater(
      _repository(user).deleteAccount(
        deleteUserData: (uid) async => user.steps.add('delete data of $uid'),
      ),
      _deletionFailed,
    );
    expect(user.steps, isEmpty);
  });

  test('asks magic-link users who signed in a while ago to sign in '
      'again', () async {
    final user = _FakeUser(
      providers: const ['password'],
      lastSignIn: anHourAgo,
      steps: [],
    );

    await expectLater(
      _repository(user).deleteAccount(
        deleteUserData: (uid) async => user.steps.add('delete data of $uid'),
      ),
      throwsA(
        isA<AuthException>().having(
          (error) => error.message,
          'message',
          'For your security, sign out and sign in again, then delete your '
              'account.',
        ),
      ),
    );
    expect(user.steps, isEmpty);
  });

  test('deletes magic-link users who just signed in', () async {
    final user = _FakeUser(
      providers: const ['password'],
      lastSignIn: aMinuteAgo,
      steps: [],
    );

    await _repository(user).deleteAccount(
      deleteUserData: (uid) async => user.steps.add('delete data of $uid'),
    );

    expect(user.steps, ['delete data of u1', 'delete account']);
  });
}
