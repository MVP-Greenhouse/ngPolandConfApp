import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_session.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/repositories/user_session_repository.dart';

/// Synchronous snapshot of the current session (e.g. for button taps).
@injectable
class GetUserSession {
  const GetUserSession(this._sessions);

  final UserSessionRepository _sessions;

  UserSession call() => _sessions.current;
}
