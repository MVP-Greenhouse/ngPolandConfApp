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
  UserSessionCubit(this._ensureUserProfile, this._userRepository)
      : super(const UserSessionState.unauthenticated()) {
    _authSub = FirebaseAuth.instance.authStateChanges().listen(_onAuth);
  }

  final EnsureUserProfile _ensureUserProfile;
  final UserRepository _userRepository;
  StreamSubscription<User?>? _authSub;
  StreamSubscription<UserProfile?>? _profileSub;

  bool get isAdmin => state.isAdmin;

  UserProfile? get currentProfile => state.profile;

  Future<void> _onAuth(User? user) async {
    await _profileSub?.cancel();
    if (user == null) {
      emit(const UserSessionState.unauthenticated());
      return;
    }
    emit(const UserSessionState.loading());
    await _ensureUserProfile(
      EnsureUserProfileParams(
        uid: user.uid,
        displayName: user.displayName ?? '',
        email: user.email ?? '',
      ),
    );
    _profileSub = _userRepository.watchProfile(user.uid).listen((profile) {
      if (profile == null) {
        emit(const UserSessionState.unauthenticated());
        return;
      }
      emit(UserSessionState.authenticated(profile));
    });
  }

  @override
  Future<void> close() async {
    await _authSub?.cancel();
    await _profileSub?.cancel();
    return super.close();
  }
}
