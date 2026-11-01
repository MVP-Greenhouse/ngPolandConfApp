import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/authentication/data/datasources/user_remote_datasource.dart';
import 'package:ng_poland_conf_app/features/authentication/data/repositories/user_repository_impl.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_role.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/exceptions/auth_exception.dart';

import '../../../../helpers/fakes.dart';

/// Holds one profile that already exists in Firestore.
class _FakeUserRemoteDataSource implements UserRemoteDataSource {
  _FakeUserRemoteDataSource(this.stored, {this.deleteError});

  UserProfile stored;

  /// When set, [deleteProfile] fails with it.
  final Object? deleteError;
  var deleted = false;

  @override
  Future<void> deleteProfile(String uid) async {
    if (deleteError case final error?) throw error;
    deleted = true;
  }

  @override
  Future<UserProfile> ensureProfile({
    required String uid,
    required String displayName,
    required String email,
  }) async => stored;

  @override
  Future<void> updateDisplayName(String uid, String displayName) async =>
      stored = UserProfile(
        uid: uid,
        displayName: displayName,
        email: stored.email,
        role: stored.role,
      );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

UserProfile _profile(String displayName) => UserProfile(
  uid: 'u1',
  displayName: displayName,
  email: 'ada@privaterelay.appleid.com',
  role: UserRole.user,
);

void main() {
  test('fills in the name on a profile created without one', () async {
    // The session can create the profile before Apple's name arrives.
    final remote = _FakeUserRemoteDataSource(_profile(''));

    final profile = await UserRepositoryImpl(remote, silentLogger)
        .ensureProfile(
          uid: 'u1',
          displayName: 'Ada Lovelace',
          email: 'ada@privaterelay.appleid.com',
        );

    expect(profile.displayName, 'Ada Lovelace');
    expect(remote.stored.displayName, 'Ada Lovelace');
  });

  test('keeps the name already on the profile', () async {
    final remote = _FakeUserRemoteDataSource(_profile('Ada'));

    final profile = await UserRepositoryImpl(remote, silentLogger)
        .ensureProfile(
          uid: 'u1',
          displayName: 'Ada Lovelace',
          email: 'ada@privaterelay.appleid.com',
        );

    expect(profile.displayName, 'Ada');
    expect(remote.stored.displayName, 'Ada');
  });

  test('deletes the profile', () async {
    final remote = _FakeUserRemoteDataSource(_profile('Ada'));

    await UserRepositoryImpl(remote, silentLogger).deleteProfile('u1');

    expect(remote.deleted, isTrue);
  });

  test('reports a profile that cannot be deleted', () async {
    final remote = _FakeUserRemoteDataSource(
      _profile('Ada'),
      deleteError: FirebaseException(
        plugin: 'cloud_firestore',
        code: 'permission-denied',
      ),
    );

    await expectLater(
      UserRepositoryImpl(remote, silentLogger).deleteProfile('u1'),
      throwsA(
        isA<AuthException>().having(
          (error) => error.message,
          'message',
          'There was a problem deleting your account.',
        ),
      ),
    );
  });
}
