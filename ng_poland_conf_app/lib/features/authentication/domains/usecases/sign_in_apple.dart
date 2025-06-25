import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/usecases/usecases.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/repositories/authentication_repository.dart';

@injectable
class SignInAppleUseCase implements UseCase<Either<String, String>, SignInAppleParams> {
  final AuthenticationRepository authenticationRepository;

  const SignInAppleUseCase(this.authenticationRepository);

  @override
  Future<Either<String, String>> call([SignInAppleParams? params]) => authenticationRepository.signInWithApple();
}

class SignInAppleParams {}
