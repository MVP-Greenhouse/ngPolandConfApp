import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/repositories/user_repository.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/usecases/ensure_user_profile.dart';

part 'user_session_state.dart';
part 'user_session_cubit.freezed.dart';

@singleton
class UserSessionCubit extends Cubit<UserSessionState> {
  UserSessionCubit(
    this._ensureUserProfile,
    this._userRepository, {
    @ignoreParam Stream<User?>? authStateChanges,
  }) : super(const UserSessionState.loading()) {
    _authSub = (authStateChanges ?? FirebaseAuth.instance.authStateChanges())
        .listen(_onAuth);
  }

  final EnsureUserProfile _ensureUserProfile;
  final UserRepository _userRepository;
  StreamSubscription<User?>? _authSub;
  StreamSubscription<UserProfile?>? _profileSub;

  bool get isAdmin => state.isAdmin;

  UserProfile? get currentProfile => state.profile;

  Future<void> _onAuth(User? user) {
    return onAuthChanged(
      uid: user?.uid,
      displayName: user?.displayName ?? '',
      email: user?.email ?? '',
    );
  }

  Future<void> onAuthChanged({
    String? uid,
    String displayName = '',
    String email = '',
  }) async {
    if (uid == null) {
      await _profileSub?.cancel();
      _profileSub = null;
      if (!isClosed) emit(const UserSessionState.unauthenticated());
      return;
    }
    if (!isClosed) emit(const UserSessionState.loading());
    await _profileSub?.cancel();
    _profileSub = null;
    try {
      await _ensureUserProfile(
        EnsureUserProfileParams(
          uid: uid,
          displayName: displayName,
          email: email,
        ),
      );
    } catch (_) {
      // Attach watchProfile anyway so a later snapshot can recover the session.
    }
    if (isClosed) return;
    try {
      _profileSub = _userRepository
          .watchProfile(uid)
          .listen(
            (profile) {
              if (isClosed) return;
              if (profile == null) {
                emit(const UserSessionState.unauthenticated());
                return;
              }
              emit(UserSessionState.authenticated(profile));
            },
            onError: (_) {
              if (!isClosed) emit(const UserSessionState.unauthenticated());
            },
          );
    } catch (_) {
      if (!isClosed) emit(const UserSessionState.unauthenticated());
    }
  }

  @override
  Future<void> close() async {
    await _authSub?.cancel();
    await _profileSub?.cancel();
    return super.close();
  }
}
