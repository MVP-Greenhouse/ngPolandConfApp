import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/sign_in_social_media_type.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/usecases/sign_in_apple.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/usecases/sign_in_google.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/widgets/social_media_button.dart';

part 'authentication_state.dart';
part 'authentication_cubit.freezed.dart';

@injectable
class AuthenticationCubit extends Cubit<AuthenticationState> {
  final SignInAppleUseCase signInAppleUseCase;
  final SignInGoogleUseCase signInGoogleUseCase;

  AuthenticationCubit(
    this.signInAppleUseCase,
    this.signInGoogleUseCase,
  ) : super(const AuthenticationState.initial());

  Future<void> signInSocialMedia(SignInSocialMediaType type) async {
    emit(AuthenticationState.inProgress(
      type: switch (type) {
        SignInGoogle() => AuthenticationType.google,
        SignInApple() => AuthenticationType.apple,
      },
    ));
    Either<String, String> signInStatus = await switch (type) {
      SignInGoogle() => signInGoogleUseCase(type.params),
      SignInApple() => signInAppleUseCase(type.params),
    };
    signInStatus.fold(
      (l) => emit(AuthenticationState.error(l)),
      (_) => emit(const AuthenticationState.authenticated()),
    );
  }
}
