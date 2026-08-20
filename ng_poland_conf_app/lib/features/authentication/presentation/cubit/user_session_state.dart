part of 'user_session_cubit.dart';

@freezed
class UserSessionState with _$UserSessionState {
  const UserSessionState._();

  const factory UserSessionState.unauthenticated() = _Unauthenticated;
  const factory UserSessionState.loading() = _Loading;
  const factory UserSessionState.authenticated(UserProfile profile) = _Authenticated;

  bool get isAdmin => maybeWhen(
        authenticated: (profile) => profile.isAdmin,
        orElse: () => false,
      );

  UserProfile? get profile => maybeWhen(
        authenticated: (profile) => profile,
        orElse: () => null,
      );
}
