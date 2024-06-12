part of 'authentication_cubit.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.initial() = _Initial;

  const factory AuthenticationState.inProgress({
    required AuthenticationType type,
  }) = _InProgress;

  const factory AuthenticationState.authenticated() = _Authenticated;

  const factory AuthenticationState.error(String text) = _Error;
}
