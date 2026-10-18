import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/domain/use_case.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/exceptions/auth_exception.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/services/email_address.dart';

@injectable
class SendMagicLink implements UseCase<void, SendMagicLinkParams> {
  const SendMagicLink(this._authentication);

  final AuthenticationRepository _authentication;

  @override
  Future<void> call(SendMagicLinkParams params) {
    if (!isValidEmailAddress(params.email)) {
      throw const AuthException('Enter a valid email address.');
    }
    return _authentication.sendSignInLink(params.email.trim());
  }
}

class SendMagicLinkParams {
  const SendMagicLinkParams({required this.email});

  final String email;
}
