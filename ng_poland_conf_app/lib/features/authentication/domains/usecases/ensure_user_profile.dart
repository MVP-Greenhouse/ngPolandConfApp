import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/usecases/usecases.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/repositories/user_repository.dart';

@injectable
class EnsureUserProfile implements UseCase<UserProfile, EnsureUserProfileParams> {
  const EnsureUserProfile(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<UserProfile> call(EnsureUserProfileParams params) {
    return _userRepository.ensureProfile(
      uid: params.uid,
      displayName: params.displayName,
      email: params.email,
    );
  }
}

class EnsureUserProfileParams {
  const EnsureUserProfileParams({
    required this.uid,
    required this.displayName,
    required this.email,
  });

  final String uid;
  final String displayName;
  final String email;
}
