import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/usecases/usecases.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/repositories/authentication_repository.dart';

@injectable
class SendMagicLinkUseCase
    implements UseCase<Either<String, String>, SendMagicLinkParams> {
  final AuthenticationRepository authenticationRepository;

  const SendMagicLinkUseCase(this.authenticationRepository);

  @override
  Future<Either<String, String>> call(SendMagicLinkParams params) =>
      authenticationRepository.sendSignInLink(params.email);
}

class SendMagicLinkParams {
  const SendMagicLinkParams({required this.email});

  final String email;
}
