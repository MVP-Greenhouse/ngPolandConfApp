import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_profile.dart';

part 'user_session.freezed.dart';

/// Current authentication state of the app user.
@freezed
sealed class UserSession with _$UserSession {
  const UserSession._();

  const factory UserSession.loading() = SessionLoading;

  const factory UserSession.signedOut() = SignedOut;

  const factory UserSession.signedIn(UserProfile profile) = SignedIn;

  UserProfile? get profile => switch (this) {
    SignedIn(:final profile) => profile,
    _ => null,
  };

  bool get isAdmin => profile?.isAdmin ?? false;
}
