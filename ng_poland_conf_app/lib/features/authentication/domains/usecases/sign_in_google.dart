import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/usecases/usecases.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/repositories/authentication_repository.dart';

@injectable
class SignInGoogleUseCase implements UseCase<Either<String, String>, SignInGoogleParams> {
  final AuthenticationRepository authenticationRepository;

  const SignInGoogleUseCase(this.authenticationRepository);

  @override
  Future<Either<String, String>> call([SignInGoogleParams? params]) => authenticationRepository.signInWithGoogle();
}

class SignInGoogleParams {}
