import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/domain/use_case.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/repositories/authentication_repository.dart';

@injectable
class SignOut implements NoParamsUseCase<void> {
  const SignOut(this._authentication);

  final AuthenticationRepository _authentication;

  @override
  Future<void> call() => _authentication.signOut();
}
