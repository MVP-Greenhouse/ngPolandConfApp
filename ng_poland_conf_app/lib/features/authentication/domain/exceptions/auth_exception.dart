import 'package:ng_poland_conf_app/core/domain/app_exception.dart';

/// A sign-in step failed; [message] is meant for the user.
class AuthException extends AppException {
  const AuthException(super.message);
}

/// Signing in worked but the user's profile document could not be saved.
class ProfileSyncException extends AuthException {
  const ProfileSyncException([
    super.message = 'There was a problem saving your profile.',
  ]);
}
