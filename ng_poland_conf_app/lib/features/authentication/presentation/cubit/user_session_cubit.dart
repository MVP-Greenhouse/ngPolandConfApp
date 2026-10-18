import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_session.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/sign_out.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/watch_user_session.dart';

/// Exposes the [UserSession] to widgets (drawer, router guards).
@singleton
class UserSessionCubit extends Cubit<UserSession> {
  UserSessionCubit(WatchUserSession watchUserSession, this._signOut)
    : super(const UserSession.loading()) {
    _subscription = watchUserSession().listen(emit);
  }

  final SignOut _signOut;
  late final StreamSubscription<UserSession> _subscription;

  /// The new session arrives through [WatchUserSession] once signed out.
  Future<void> signOut() => _signOut();

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
