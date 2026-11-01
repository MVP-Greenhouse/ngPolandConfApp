import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/authentication_type.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/exceptions/auth_exception.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/complete_magic_link.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/send_magic_link.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/sign_in_with_apple.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/sign_in_with_google.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/magic_link_listener.dart';

part 'authentication_cubit.freezed.dart';
part 'authentication_state.dart';

@injectable
class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(
    this._signInWithGoogle,
    this._signInWithApple,
    this._sendMagicLink,
    this._completeMagicLink,
    MagicLinkListener magicLinkListener,
    this._logger,
  ) : super(const AuthenticationState.initial()) {
    // Deep-link completion happens outside this screen; surface its errors.
    _magicLinkErrors = magicLinkListener.errors.listen(reportExternalError);
  }

  final SignInWithGoogle _signInWithGoogle;
  final SignInWithApple _signInWithApple;
  final SendMagicLink _sendMagicLink;
  final CompleteMagicLink _completeMagicLink;
  final Logger _logger;
  late final StreamSubscription<String> _magicLinkErrors;

  Future<void> signInWithGoogle() => _signIn(.google, _signInWithGoogle.call);

  Future<void> signInWithApple() => _signIn(.apple, _signInWithApple.call);

  Future<void> completeMagicLink(String emailLink) => _signIn(
    .email,
    () => _completeMagicLink(CompleteMagicLinkParams(emailLink: emailLink)),
  );

  Future<void> sendMagicLink(String email) async {
    emit(const AuthenticationState.inProgress(type: .email));
    try {
      await _sendMagicLink(SendMagicLinkParams(email: email));
      emit(AuthenticationState.linkSent(email: email.trim()));
    } on AuthException catch (error, stackTrace) {
      _fail(error, stackTrace);
    }
  }

  void reportExternalError(String message) =>
      emit(AuthenticationState.error(message));

  Future<void> _signIn(
    AuthenticationType type,
    Future<UserProfile> Function() signIn,
  ) async {
    emit(AuthenticationState.inProgress(type: type));
    try {
      await signIn();
      emit(const AuthenticationState.authenticated());
    } on AuthException catch (error, stackTrace) {
      _fail(error, stackTrace);
    }
  }

  void _fail(AuthException error, StackTrace stackTrace) {
    _logger.w('Authentication failed', error: error, stackTrace: stackTrace);
    emit(AuthenticationState.error(error.message));
  }

  @override
  Future<void> close() async {
    await _magicLinkErrors.cancel();
    return super.close();
  }
}
