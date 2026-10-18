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
      return await _userRemoteDataSource.ensureProfile(
        uid: uid,
        displayName: displayName,
        email: email,
      );
    } on FirebaseException catch (error, stackTrace) {
      _logger.w('Profile sync failed', error: error, stackTrace: stackTrace);
      throw const ProfileSyncException();
    }
  }

  @override
  Stream<UserProfile?> watchProfile(String uid) =>
      _userRemoteDataSource.watchProfile(uid);
}
