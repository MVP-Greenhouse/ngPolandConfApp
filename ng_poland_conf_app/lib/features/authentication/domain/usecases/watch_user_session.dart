import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/domain/use_case.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_session.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/repositories/user_session_repository.dart';

@injectable
class WatchUserSession implements NoParamsStreamUseCase<UserSession> {
  const WatchUserSession(this._sessions);

  final UserSessionRepository _sessions;

  @override
  Stream<UserSession> call() => _sessions.watch();
}
