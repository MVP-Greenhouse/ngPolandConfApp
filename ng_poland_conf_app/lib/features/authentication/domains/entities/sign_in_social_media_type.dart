import 'package:ng_poland_conf_app/features/authentication/domains/usecases/sign_in_apple.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/usecases/sign_in_google.dart';

sealed class SignInSocialMediaType {
  const SignInSocialMediaType();
}

class SignInApple extends SignInSocialMediaType {
  final SignInAppleParams? params;

  SignInApple([this.params]);
}

class SignInGoogle extends SignInSocialMediaType {
  final SignInGoogleParams? params;

  SignInGoogle([this.params]);
}
