import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_role.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/repositories/authentication_repository.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/repositories/user_repository.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/usecases/complete_magic_link.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/usecases/ensure_user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/usecases/send_magic_link.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/usecases/sign_in_apple.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/usecases/sign_in_google.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/authentication_cubit.dart';

class _AuthRepo implements AuthenticationRepository {
  _AuthRepo({
    this.sendResult,
    this.completeResult,
  });

  Either<String, String>? sendResult;
  Either<String, String>? completeResult;
  String? lastSendEmail;
  String? lastCompleteLink;

  @override
  Future<Either<String, String>> signInWithApple() async => right('ok');

  @override
  Future<Either<String, String>> signInWithGoogle() async => right('ok');

  @override
  Future<Either<String, String>> sendSignInLink(String email) async {
    lastSendEmail = email;
    return sendResult ?? right('sent');
  }

  @override
  Future<Either<String, String>> completeSignInWithEmailLink(
    String emailLink,
  ) async {
    lastCompleteLink = emailLink;
    return completeResult ??
        left('No saved email. Send the link again on this device.');
  }
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

AuthenticationCubit _cubit(
  UserRepository repo, {
  AuthenticationRepository? authRepo,
}) {
  final resolvedAuthRepo = authRepo ?? _AuthRepo();
  return AuthenticationCubit(
    SignInAppleUseCase(resolvedAuthRepo),
    SignInGoogleUseCase(resolvedAuthRepo),
    SendMagicLinkUseCase(resolvedAuthRepo),
    CompleteMagicLinkUseCase(resolvedAuthRepo),
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
      const AuthenticationState.error('There was a problem saving your profile.'),
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

  test('sendMagicLink emits linkSent on success', () async {
    final authRepo = _AuthRepo(sendResult: right('sent'));
    final cubit = _cubit(_OkUserRepository(), authRepo: authRepo);

    await cubit.sendMagicLink(' ada@example.com ');

    expect(authRepo.lastSendEmail, ' ada@example.com ');
    expect(
      cubit.state,
      const AuthenticationState.linkSent(email: 'ada@example.com'),
    );
    await cubit.close();
  });

  test('sendMagicLink emits error on failure', () async {
    final authRepo = _AuthRepo(sendResult: left('fail'));
    final cubit = _cubit(_OkUserRepository(), authRepo: authRepo);

    await cubit.sendMagicLink('ada@example.com');

    expect(cubit.state, const AuthenticationState.error('fail'));
    await cubit.close();
  });

  test('completeMagicLink emits error when pending email missing', () async {
    final authRepo = _AuthRepo(
      completeResult: left(
        'No saved email. Send the link again on this device.',
      ),
    );
    final cubit = _cubit(_OkUserRepository(), authRepo: authRepo);

    await cubit.completeMagicLink('https://example.com/auth?link=1');

    expect(
      cubit.state,
      const AuthenticationState.error(
        'No saved email. Send the link again on this device.',
      ),
    );
    expect(authRepo.lastCompleteLink, 'https://example.com/auth?link=1');
    await cubit.close();
  });
}
