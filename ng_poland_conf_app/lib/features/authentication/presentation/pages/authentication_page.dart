import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/core/presentation/navigation/app_pages.dart';
import 'package:ng_poland_conf_app/core/presentation/navigation/redirect_paths.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/apple_sign_in_support.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/authentication_type.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/widgets/auth_ui_tokens.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/widgets/magic_link_form.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/widgets/social_media_button.dart';
import 'package:ng_poland_conf_app/features/home/presentation/cubit/conferences_cubit.dart';

/// Email sign-in is switched off in Firebase for now. To bring it back, turn it
/// on there and set this to true.
bool get _emailSignInEnabled => false;

/// Sign-in screen. Expects an [AuthenticationCubit] above it.
class AuthenticationPage extends HookWidget {
  static const String path = AppPaths.auth;

  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Captured on first build: after sign-in the router refreshes and may
    // remove this page before the listener below runs.
    final from = useMemoized(
      () => safeInternalRedirectPath(
        GoRouterState.of(context).uri.queryParameters['from'],
      ),
    );
    final confId = context.select(
      (ConferencesCubit cubit) => cubit.state.selected?.confId,
    );
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: BlocListener<AuthenticationCubit, AuthenticationState>(
        listenWhen: (_, state) => state is Authenticated,
        listener: (context, _) => _leave(context, to: from),
        child: Stack(
          fit: .expand,
          children: [
            const DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background_blured.jpg'),
                  fit: .cover,
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.surface.withValues(alpha: 0.55),
              ),
            ),
            const Positioned.fill(child: _AuthAmbientGlow()),
            SafeArea(
              child: Column(
                children: [
                  _AuthHeader(onClose: () => _leave(context)),
                  Expanded(
                    child: _AuthBody(
                      editionLabel: confId == null || confId.isEmpty
                          ? 'Warsaw Live'
                          : 'Edition $confId • Warsaw Live',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void _leave(BuildContext context, {String? to}) {
    if (to != null) return context.go(to);
    if (context.canPop()) return context.pop();
    context.go(Pages.home.path);
  }
}

class _AuthBody extends StatelessWidget {
  const _AuthBody({required this.editionLabel});

  final String editionLabel;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthenticationCubit>();
    final state = context.watch<AuthenticationCubit>().state;
    final (busyType, linkSentEmail, errorText) = switch (state) {
      AuthenticationInProgress(:final type) => (type, null, null),
      AuthenticationLinkSent(:final email) => (null, email, null),
      AuthenticationError(:final text) => (null, null, text),
      AuthenticationInitial() || Authenticated() => (null, null, null),
    };

    return IgnorePointer(
      ignoring: busyType != null,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        behavior: .opaque,
        child: CustomScrollView(
          keyboardDismissBehavior: .onDrag,
          slivers: [
            // Fills the viewport so the footer sits at the bottom, and grows
            // with the content so taller layouts still scroll. Padding lives
            // inside: a SliverPadding around it would add the bottom inset on
            // top of the filled height and always overflow the viewport.
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const .fromLTRB(16, 8, 16, 24),
                child: Column(
                  crossAxisAlignment: .stretch,
                  children: [
                    _AuthHero(editionLabel: editionLabel),
                    const SizedBox(height: 24),
                    SocialMediaButton(
                      isLoading: busyType == .google,
                      onTap: cubit.signInWithGoogle,
                      authenticationType: .google,
                    ),
                    if (supportsAppleSignIn()) ...[
                      const SizedBox(height: 10),
                      SocialMediaButton(
                        isLoading: busyType == .apple,
                        onTap: cubit.signInWithApple,
                        authenticationType: .apple,
                      ),
                    ],
                    if (_emailSignInEnabled) ...[
                      const SizedBox(height: 24),
                      const _MagicLinkDivider(),
                      const SizedBox(height: 16),
                      MagicLinkForm(
                        isLoading: busyType == AuthenticationType.email,
                        linkSent: linkSentEmail != null,
                        initialEmail: linkSentEmail ?? '',
                        onSubmit: cubit.sendMagicLink,
                      ),
                    ],
                    if (errorText != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        errorText,
                        textAlign: .center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontWeight: .w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                    const SizedBox(height: 28),
                    const Spacer(),
                    const _AuthFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthHeader extends StatelessWidget {
  const _AuthHeader({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: SizedBox(
        height: 56,
        child: Row(
          children: [
            IconButton(
              onPressed: onClose,
              tooltip: 'Close',
              icon: Icon(
                Icons.close_rounded,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
            Expanded(
              child: Text(
                'Sign In',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.white.withValues(alpha: 0.95),
                ),
              ),
            ),
            const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }
}

class _AuthHero extends StatelessWidget {
  const _AuthHero({required this.editionLabel});

  final String editionLabel;

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).colorScheme.secondary;

    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: AuthUiTokens.chipBg,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AuthUiTokens.fieldBorder),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox.square(
                  dimension: 8,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: accent,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: accent.withValues(alpha: 0.65),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  editionLabel.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                    color: accent,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AuthUiTokens.fieldBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: accent.withValues(alpha: 0.35)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
              BoxShadow(color: accent.withValues(alpha: 0.4), blurRadius: 28),
            ],
          ),
          child: Icon(Icons.verified_user_rounded, size: 34, color: accent),
        ),
        const SizedBox(height: 16),
        Text.rich(
          TextSpan(
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.2,
            ),
            children: [
              const TextSpan(text: 'Welcome to '),
              TextSpan(
                text: 'NG Poland!',
                style: TextStyle(color: accent),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Get access to live Top 5 voting.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.72),
            height: 1.4,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _MagicLinkDivider extends StatelessWidget {
  const _MagicLinkDivider();

  @override
  Widget build(BuildContext context) {
    const line = Expanded(
      child: ColoredBox(
        color: AuthUiTokens.fieldBorder,
        child: SizedBox(height: 1),
      ),
    );

    return Row(
      children: [
        line,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'or use a Magic Link',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.65),
            ),
          ),
        ),
        line,
      ],
    );
  }
}

class _AuthFooter extends StatelessWidget {
  const _AuthFooter();

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).colorScheme.secondary;
    final base = TextStyle(
      fontSize: 12,
      height: 1.45,
      color: Colors.white.withValues(alpha: 0.68),
    );
    final linkStyle = base.copyWith(color: accent, fontWeight: FontWeight.w700);

    return Column(
      children: [
        Text.rich(
          TextSpan(
            style: base,
            children: [
              const TextSpan(text: 'By signing in, you accept the '),
              TextSpan(text: 'Conference Terms', style: linkStyle),
              const TextSpan(text: ' and '),
              TextSpan(text: 'Privacy Policy', style: linkStyle),
              const TextSpan(text: ' of NG Poland.'),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          'Warsaw',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.white.withValues(alpha: 0.45),
          ),
        ),
      ],
    );
  }
}

class _AuthAmbientGlow extends StatelessWidget {
  const _AuthAmbientGlow();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    // Soft blobs like Stitch `blur-[80px]` — not hard-edged circles.
    final pink = scheme.secondary;
    final violet = scheme.secondaryContainer;

    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -90,
            left: 0,
            right: 0,
            child: Center(
              child: _BlurredOrb(
                size: 280,
                blurSigma: 56,
                color: pink.withValues(alpha: 0.45),
              ),
            ),
          ),
          Positioned(
            top: 120,
            right: -100,
            child: _BlurredOrb(
              size: 220,
              blurSigma: 48,
              color: violet.withValues(alpha: 0.35),
            ),
          ),
        ],
      ),
    );
  }
}

class _BlurredOrb extends StatelessWidget {
  const _BlurredOrb({
    required this.size,
    required this.blurSigma,
    required this.color,
  });

  final double size;
  final double blurSigma;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(
        sigmaX: blurSigma,
        sigmaY: blurSigma,
        tileMode: TileMode.decal,
      ),
      child: SizedBox.square(
        dimension: size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [color, color.withValues(alpha: 0)],
            ),
          ),
        ),
      ),
    );
  }
}
