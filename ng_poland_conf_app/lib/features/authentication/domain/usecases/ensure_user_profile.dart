import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/domain/use_case.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/auth_user.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/repositories/user_repository.dart';

@injectable
class EnsureUserProfile implements UseCase<UserProfile, AuthUser> {
  const EnsureUserProfile(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<UserProfile> call(AuthUser user) => _userRepository.ensureProfile(
    uid: user.uid,
    displayName: user.displayName,
    email: user.email,
  );
}
