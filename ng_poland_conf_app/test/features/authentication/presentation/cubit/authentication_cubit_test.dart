import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/exceptions/auth_exception.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/complete_magic_link.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/ensure_user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/handle_magic_link.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/send_magic_link.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/sign_in_with_apple.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/sign_in_with_google.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/watch_incoming_links.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/magic_link_listener.dart';

import '../../../../helpers/fakes.dart';

void main() {
  late FakeAuthenticationRepository auth;
  late FakeIncomingLinksRepository links;
  late AuthenticationCubit cubit;

  AuthenticationCubit build(FakeUserRepository users) {
    final ensureProfile = EnsureUserProfile(users);
    final completeMagicLink = CompleteMagicLink(auth, ensureProfile);
    return AuthenticationCubit(
      SignInWithGoogle(auth, ensureProfile),
      SignInWithApple(auth, ensureProfile),
      SendMagicLink(auth),
      completeMagicLink,
      MagicLinkListener(
        WatchIncomingLinks(links),
        HandleMagicLink(auth, completeMagicLink),
        silentLogger,
      ),
      silentLogger,
    );
  }

  setUp(() {
    auth = FakeAuthenticationRepository();
    links = FakeIncomingLinksRepository();
  });

  tearDown(() async {
    await cubit.close();
    await auth.dispose();
    await links.dispose();
  });

  test('emits authenticated when sign-in and profile sync succeed', () async {
    cubit = build(FakeUserRepository());

    await cubit.signInWithGoogle();

    expect(cubit.state, const AuthenticationState.authenticated());
  });

  test('emits the profile error when saving the profile fails', () async {
    cubit = build(
      FakeUserRepository(ensureError: const ProfileSyncException()),
    );

    await cubit.signInWithApple();

    expect(
      cubit.state,
      const AuthenticationState.error(
        'There was a problem saving your profile.',
      ),
    );
  });

  test('sendMagicLink emits linkSent with the trimmed email', () async {
    cubit = build(FakeUserRepository());

    await cubit.sendMagicLink(' ada@example.com ');

    expect(auth.lastSentEmail, 'ada@example.com');
    expect(
      cubit.state,
      const AuthenticationState.linkSent(email: 'ada@example.com'),
    );
  });

  test(
    'sendMagicLink rejects an invalid address before calling Firebase',
    () async {
      cubit = build(FakeUserRepository());

      await cubit.sendMagicLink('not-an-email');

      expect(auth.lastSentEmail, isNull);
      expect(
        cubit.state,
        const AuthenticationState.error('Enter a valid email address.'),
      );
    },
  );

  test('completeMagicLink reports repository failures', () async {
    auth.failure = const AuthException(
      'No saved email. Send the link again on this device.',
    );
    cubit = build(FakeUserRepository());

    await cubit.completeMagicLink('https://example.com/auth?link=1');

    expect(auth.lastCompletedLink, 'https://example.com/auth?link=1');
    expect(
      cubit.state,
      const AuthenticationState.error(
        'No saved email. Send the link again on this device.',
      ),
    );
  });
}
