import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/sign_in_social_media_type.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/services/magic_link_deep_link_listener.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/widgets/auth_ui_tokens.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/widgets/magic_link_form.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/widgets/social_media_button.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/routing/routing.dart';

class AuthenticationPage extends StatefulWidget {
  static const String path = '/auth';

  static String loginPath({String? from}) {
    final safeFrom = safeInternalRedirectPath(from);
    if (safeFrom == null) return AuthenticationPage.path;
    return '${AuthenticationPage.path}?from=${Uri.encodeComponent(safeFrom)}';
  }

  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  late final AuthenticationCubit authenticationCubit;
  late final ConferencesCubit _conferencesCubit;
  StreamSubscription<String>? _magicLinkErrorsSub;
  String? _from;

  @override
  void initState() {
    authenticationCubit = getIt.get<AuthenticationCubit>();
    _conferencesCubit = getIt.get<ConferencesCubit>();
    _magicLinkErrorsSub =
        getIt.get<MagicLinkDeepLinkListener>().errors.listen(
              authenticationCubit.reportExternalError,
            );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Capture before login completes: UserSessionCubit → router.refresh()
    // can remove this page from the route tree before the BlocListener runs.
    _from ??= safeInternalRedirectPath(
      GoRouterState.of(context).uri.queryParameters['from'],
    );
  }

  @override
  void dispose() {
    _magicLinkErrorsSub?.cancel();
    authenticationCubit.close();
    super.dispose();
  }

  void _onAuthenticated(BuildContext context) {
    final from = safeInternalRedirectPath(_from);
    if (from != null) {
      context.go(from);
      return;
    }
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.go(Pages.home.path);
  }

  void _onClose(BuildContext context) {
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.go(Pages.home.path);
  }

  String _editionLabel() {
    final confId = _conferencesCubit.state.maybeWhen(
          loaded: (_, conference) => conference.confId,
          orElse: () => null,
        );
    final year = (confId != null && confId.isNotEmpty) ? confId : '2025';
    return 'Edition $year • Warsaw Live';
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: BlocProvider.value(
        value: authenticationCubit,
        child: BlocListener<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) {
            state.maybeWhen(
              authenticated: () => _onAuthenticated(context),
              orElse: () {},
            );
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              const DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background_blured.jpg'),
                    fit: BoxFit.cover,
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
                    _AuthHeader(onClose: () => _onClose(context)),
                    Expanded(
                      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
                        builder: (context, state) {
                          final isBusy = state.maybeWhen(
                            inProgress: (_) => true,
                            orElse: () => false,
                          );
                          final linkSentEmail = state.maybeWhen(
                            linkSent: (email) => email,
                            orElse: () => null,
                          );
                          final errorText = state.maybeWhen(
                            error: (text) => text,
                            orElse: () => null,
                          );

                          return IgnorePointer(
                            ignoring: isBusy,
                            child: GestureDetector(
                              onTap: () => FocusManager.instance.primaryFocus
                                  ?.unfocus(),
                              behavior: HitTestBehavior.opaque,
                              child: SingleChildScrollView(
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _AuthHero(editionLabel: _editionLabel()),
                                  const SizedBox(height: 24),
                                  SocialMediaButton(
                                    isLoading: state.maybeMap(
                                      inProgress: (value) =>
                                          value.type == AuthenticationType.google,
                                      orElse: () => false,
                                    ),
                                    onTap: () => authenticationCubit
                                        .signInSocialMedia(SignInGoogle()),
                                    authenticationType: AuthenticationType.google,
                                  ),
                                  if (Platform.isIOS) ...[
                                    const SizedBox(height: 10),
                                    SocialMediaButton(
                                      isLoading: state.maybeMap(
                                        inProgress: (value) =>
                                            value.type == AuthenticationType.apple,
                                        orElse: () => false,
                                      ),
                                      onTap: () => authenticationCubit
                                          .signInSocialMedia(SignInApple()),
                                      authenticationType: AuthenticationType.apple,
                                    ),
                                  ],
                                  const SizedBox(height: 24),
                                  const _MagicLinkDivider(),
                                  const SizedBox(height: 16),
                                  MagicLinkForm(
                                    isLoading: state.maybeMap(
                                      inProgress: (value) =>
                                          value.type == AuthenticationType.email,
                                      orElse: () => false,
                                    ),
                                    linkSent: linkSentEmail != null,
                                    initialEmail: linkSentEmail ?? '',
                                    onSubmit: authenticationCubit.sendMagicLink,
                                  ),
                                  if (errorText != null) ...[
                                    const SizedBox(height: 12),
                                    Text(
                                      errorText,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: scheme.error,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                  const SizedBox(height: 28),
                                  const _AuthFooter(),
                                ],
                              ),
                            ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
    final accent = Theme.of(context).colorScheme.secondary;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 12, 4),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: AuthUiTokens.chipBg,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AuthUiTokens.fieldBorder,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: Text(
                        'NG Poland',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          color: accent,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Sign In',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.white.withValues(alpha: 0.95),
                        ),
                  ),
                ],
              ),
            ),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: accent.withValues(alpha: 0.45),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: const Icon(
                Icons.person_rounded,
                size: 18,
                color: Colors.white,
              ),
            ),
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
                Container(
                  width: 8,
                  height: 8,
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
            border: Border.all(
              color: accent.withValues(alpha: 0.35),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: accent.withValues(alpha: 0.4),
                blurRadius: 28,
              ),
            ],
          ),
          child: Icon(
            Icons.verified_user_rounded,
            size: 34,
            color: accent,
          ),
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
    final line = Expanded(
      child: ColoredBox(
        color: AuthUiTokens.fieldBorder,
        child: const SizedBox(height: 1),
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
    final linkStyle = base.copyWith(
      color: accent,
      fontWeight: FontWeight.w700,
    );

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
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color,
              color.withValues(alpha: 0),
            ],
          ),
        ),
      ),
    );
  }
}
