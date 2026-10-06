import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/sign_in_social_media_type.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/usecases/complete_magic_link.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/usecases/ensure_user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/usecases/send_magic_link.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/usecases/sign_in_apple.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/usecases/sign_in_google.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/widgets/social_media_button.dart';

part 'authentication_state.dart';
part 'authentication_cubit.freezed.dart';

@injectable
class AuthenticationCubit extends Cubit<AuthenticationState> {
  final SignInAppleUseCase signInAppleUseCase;
  final SignInGoogleUseCase signInGoogleUseCase;
  final SendMagicLinkUseCase sendMagicLinkUseCase;
  final CompleteMagicLinkUseCase completeMagicLinkUseCase;
  final EnsureUserProfile ensureUserProfile;

  AuthenticationCubit(
    this.signInAppleUseCase,
    this.signInGoogleUseCase,
    this.sendMagicLinkUseCase,
    this.completeMagicLinkUseCase,
    this.ensureUserProfile,
  ) : super(const AuthenticationState.initial());

  Future<void> signInSocialMedia(SignInSocialMediaType type) async {
    emit(
      AuthenticationState.inProgress(
        type: switch (type) {
          SignInGoogle() => AuthenticationType.google,
          SignInApple() => AuthenticationType.apple,
        },
      ),
    );
    Either<String, String> signInStatus = await switch (type) {
      SignInGoogle() => signInGoogleUseCase(type.params),
      SignInApple() => signInAppleUseCase(type.params),
    };
    await signInStatus.fold((l) async => emit(AuthenticationState.error(l)), (
      _,
    ) async {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await ensureProfileAfterSignIn(
          uid: user.uid,
          displayName: user.displayName ?? '',
          email: user.email ?? '',
        );
        return;
      }
      emit(const AuthenticationState.authenticated());
    });
  }

  Future<void> sendMagicLink(String email) async {
    emit(const AuthenticationState.inProgress(type: AuthenticationType.email));
    final result = await sendMagicLinkUseCase(
      SendMagicLinkParams(email: email),
    );
    result.fold(
      (error) => emit(AuthenticationState.error(error)),
      (_) => emit(AuthenticationState.linkSent(email: email.trim())),
    );
  }

  void reportExternalError(String message) {
    emit(AuthenticationState.error(message));
  }

  Future<void> completeMagicLink(String emailLink) async {
    emit(const AuthenticationState.inProgress(type: AuthenticationType.email));
    final result = await completeMagicLinkUseCase(
      CompleteMagicLinkParams(emailLink: emailLink),
    );
    await result.fold((l) async => emit(AuthenticationState.error(l)), (
      _,
    ) async {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await ensureProfileAfterSignIn(
          uid: user.uid,
          displayName: user.displayName ?? '',
          email: user.email ?? '',
        );
        return;
      }
      emit(const AuthenticationState.authenticated());
    });
  }

  Future<void> ensureProfileAfterSignIn({
    required String uid,
    required String displayName,
    required String email,
  }) async {
    try {
      await ensureUserProfile(
        EnsureUserProfileParams(
          uid: uid,
          displayName: displayName,
          email: email,
        ),
      );
    } catch (_) {
      emit(
        const AuthenticationState.error('There was a problem saving your profile.'),
      );
      return;
    }
    emit(const AuthenticationState.authenticated());
  }
}
