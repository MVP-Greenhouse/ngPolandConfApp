import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:ng_poland_conf_app/features/authentication/data/datasources/user_remote_datasource.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/exceptions/auth_exception.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/repositories/user_repository.dart';

@Singleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl(this._userRemoteDataSource, this._logger);

  final UserRemoteDataSource _userRemoteDataSource;
  final Logger _logger;

  @override
  Future<UserProfile> ensureProfile({
    required String uid,
    required String displayName,
    required String email,
  }) async {
    try {
      final profile = await _userRemoteDataSource.ensureProfile(
        uid: uid,
        displayName: displayName,
        email: email,
      );
      // The session can create the profile before the sign-in flow has the
      // name (Apple shares it only once), so fill it in when it's missing.
      if (profile.displayName.isNotEmpty || displayName.isEmpty) {
        return profile;
      }
      await _userRemoteDataSource.updateDisplayName(uid, displayName);
      return UserProfile(
        uid: uid,
        displayName: displayName,
        email: profile.email,
        role: profile.role,
      );
    } on FirebaseException catch (error, stackTrace) {
      _logger.w('Profile sync failed', error: error, stackTrace: stackTrace);
      throw const ProfileSyncException();
    }
  }

  @override
  Stream<UserProfile?> watchProfile(String uid) =>
      _userRemoteDataSource.watchProfile(uid);

  @override
  Future<void> deleteProfile(String uid) async {
    try {
      await _userRemoteDataSource.deleteProfile(uid);
    } on FirebaseException catch (error, stackTrace) {
      _logger.w('Profile delete failed', error: error, stackTrace: stackTrace);
      throw const AuthException('There was a problem deleting your account.');
    }
  }
}
