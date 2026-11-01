import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/domain/use_case.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/repositories/user_repository.dart';

/// Deletes the signed-in account and the user's profile. Their votes stay,
/// still holding the deleted user's id.
@injectable
class DeleteAccount implements NoParamsUseCase<void> {
  const DeleteAccount(this._authentication, this._users);

  final AuthenticationRepository _authentication;
  final UserRepository _users;

  @override
  Future<void> call() =>
      _authentication.deleteAccount(deleteUserData: _users.deleteProfile);
}
