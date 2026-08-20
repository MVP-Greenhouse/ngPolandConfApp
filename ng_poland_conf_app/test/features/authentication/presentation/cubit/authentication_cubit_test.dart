import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_role.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/repositories/authentication_repository.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/repositories/user_repository.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/usecases/ensure_user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/usecases/sign_in_apple.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/usecases/sign_in_google.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/authentication_cubit.dart';

class _AuthRepo implements AuthenticationRepository {
  @override
  Future<Either<String, String>> signInWithApple() async => right('ok');

  @override
  Future<Either<String, String>> signInWithGoogle() async => right('ok');
}

class _ThrowingUserRepository implements UserRepository {
  @override
  Future<UserProfile> ensureProfile({
    required String uid,
    required String displayName,
    required String email,
  }) async {
    throw Exception('firestore unavailable');
  }

  @override
  Stream<UserProfile?> watchProfile(String uid) => Stream.value(null);
}

class _OkUserRepository implements UserRepository {
  @override
  Future<UserProfile> ensureProfile({
    required String uid,
    required String displayName,
    required String email,
  }) async {
    return UserProfile(
      uid: uid,
      displayName: displayName,
      email: email,
      role: UserRole.user,
    );
  }

  @override
  Stream<UserProfile?> watchProfile(String uid) => Stream.value(null);
}

AuthenticationCubit _cubit(UserRepository repo) {
  final authRepo = _AuthRepo();
  return AuthenticationCubit(
    SignInAppleUseCase(authRepo),
    SignInGoogleUseCase(authRepo),
    EnsureUserProfile(repo),
  );
}

void main() {
  test('emits error when ensureUserProfile throws after sign-in', () async {
    final cubit = _cubit(_ThrowingUserRepository());

    await cubit.ensureProfileAfterSignIn(
      uid: 'u1',
      displayName: 'Ada',
      email: 'ada@example.com',
    );

    expect(
      cubit.state,
      const AuthenticationState.error('Wystąpił problem z zapisem profilu.'),
    );
    await cubit.close();
  });

  test('emits authenticated when ensureUserProfile succeeds', () async {
    final cubit = _cubit(_OkUserRepository());

    await cubit.ensureProfileAfterSignIn(
      uid: 'u1',
      displayName: 'Ada',
      email: 'ada@example.com',
    );

    expect(cubit.state, const AuthenticationState.authenticated());
    await cubit.close();
  });
}
