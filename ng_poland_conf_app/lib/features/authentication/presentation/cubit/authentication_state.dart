part of 'authentication_cubit.dart';

@freezed
sealed class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.initial() = AuthenticationInitial;

  const factory AuthenticationState.inProgress({
    required AuthenticationType type,
  }) = AuthenticationInProgress;

  const factory AuthenticationState.linkSent({required String email}) =
      AuthenticationLinkSent;

  const factory AuthenticationState.authenticated() = Authenticated;

  const factory AuthenticationState.error(String text) = AuthenticationError;
}
