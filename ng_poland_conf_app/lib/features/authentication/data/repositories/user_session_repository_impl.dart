import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/auth_user.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_session.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/repositories/user_repository.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/repositories/user_session_repository.dart';
import 'package:rxdart/rxdart.dart';

/// Follows Firebase auth state and the signed-in user's profile document.
@LazySingleton(as: UserSessionRepository)
class UserSessionRepositoryImpl implements UserSessionRepository {
  UserSessionRepositoryImpl(this._authentication, this._users, this._logger);

  final AuthenticationRepository _authentication;
  final UserRepository _users;
  final Logger _logger;

  final _session = BehaviorSubject<UserSession>.seeded(
    const UserSession.loading(),
  );
  StreamSubscription<UserSession>? _subscription;

  @override
  UserSession get current => _session.value;

  @override
  Stream<UserSession> watch() {
    _subscription ??= _authentication
        .watchAuthUser()
        .switchMap(_sessionFor)
        .listen(_session.add);
    return _session.stream;
  }

  Stream<UserSession> _sessionFor(AuthUser? user) async* {
    if (user == null) {
      yield const UserSession.signedOut();
      return;
    }
    yield const UserSession.loading();
    try {
      await _users.ensureProfile(
        uid: user.uid,
        displayName: user.displayName,
        email: user.email,
      );
    } on Exception catch (error, stackTrace) {
      // Keep going: a later profile snapshot can still recover the session.
      _logger.w(
        'Session: ensure profile failed',
        error: error,
        stackTrace: stackTrace,
      );
    }
    try {
      yield* _users
          .watchProfile(user.uid)
          .map(
            (profile) => profile == null
                ? const UserSession.signedOut()
                : UserSession.signedIn(profile),
          )
          .onErrorReturnWith((error, stackTrace) {
            _logger.w(
              'Session: profile stream failed',
              error: error,
              stackTrace: stackTrace,
            );
            return const UserSession.signedOut();
          });
    } on Exception catch (error, stackTrace) {
      _logger.w(
        'Session: watching profile failed',
        error: error,
        stackTrace: stackTrace,
      );
      yield const UserSession.signedOut();
    }
  }

  /// Releases the auth subscription (used by tests; the app keeps it alive).
  Future<void> dispose() async {
    await _subscription?.cancel();
    await _session.close();
  }
}
