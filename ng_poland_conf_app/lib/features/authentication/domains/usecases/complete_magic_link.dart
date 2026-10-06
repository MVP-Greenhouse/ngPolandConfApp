import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/usecases/usecases.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/repositories/authentication_repository.dart';

@injectable
class CompleteMagicLinkUseCase
    implements UseCase<Either<String, String>, CompleteMagicLinkParams> {
  final AuthenticationRepository authenticationRepository;

  const CompleteMagicLinkUseCase(this.authenticationRepository);

  @override
  Future<Either<String, String>> call(CompleteMagicLinkParams params) =>
      authenticationRepository.completeSignInWithEmailLink(params.emailLink);
}

class CompleteMagicLinkParams {
  const CompleteMagicLinkParams({required this.emailLink});

  final String emailLink;
}
