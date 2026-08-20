import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/authentication/datasources/data/user_remote_datasource.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/repositories/user_repository.dart';

@Singleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl(this._userRemoteDataSource);

  final UserRemoteDataSource _userRemoteDataSource;

  @override
  Future<UserProfile> ensureProfile({
    required String uid,
    required String displayName,
    required String email,
  }) {
    return _userRemoteDataSource.ensureProfile(
      uid: uid,
      displayName: displayName,
      email: email,
    );
  }

  @override
  Stream<UserProfile?> watchProfile(String uid) {
    return _userRemoteDataSource.watchProfile(uid);
  }
}
