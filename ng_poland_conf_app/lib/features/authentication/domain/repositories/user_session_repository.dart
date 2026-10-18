import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_session.dart';

/// Single shared source of the current [UserSession].
abstract interface class UserSessionRepository {
  UserSession get current;

  /// Replays [current] to new listeners, then emits every change.
  Stream<UserSession> watch();
}
