import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/domain/use_case.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/ensure_user_profile.dart';

/// Signs in with Google and makes sure the user's profile exists.
@injectable
class SignInWithGoogle implements NoParamsUseCase<UserProfile> {
  const SignInWithGoogle(this._authentication, this._ensureUserProfile);

  final AuthenticationRepository _authentication;
  final EnsureUserProfile _ensureUserProfile;

  @override
  Future<UserProfile> call() async =>
      _ensureUserProfile(await _authentication.signInWithGoogle());
}
