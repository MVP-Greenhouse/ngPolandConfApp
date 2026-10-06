import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/widgets/auth_ui_tokens.dart';
import 'package:ng_poland_conf_app/widgets/icon_with_darkmode.dart';

enum AuthenticationType {
  google,
  apple,
  email;

  String getIconAsset() => switch (this) {
        google => 'auth_with_google.png',
        apple => 'auth_with_apple.png',
        email => 'auth_with_google.png',
      };

  String getTitle() => switch (this) {
        google => 'Continue with Google',
        apple => 'Continue with Apple',
        email => 'Send Magic Link',
      };
}

class SocialMediaButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isLoading;
  final AuthenticationType authenticationType;

  const SocialMediaButton({
    super.key,
    required this.onTap,
    required this.isLoading,
    required this.authenticationType,
  });

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).colorScheme.secondary;

    return SizedBox(
      height: 48,
      width: double.infinity,
      child: IgnorePointer(
        ignoring: isLoading,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AuthUiTokens.fieldBg.withValues(
              alpha: isLoading ? 0.65 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AuthUiTokens.fieldBorder),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: accent.withValues(alpha: 0.08),
                blurRadius: 16,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isLoading)
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    else
                      IconWithDarkMode(
                        imageName: authenticationType.getIconAsset(),
                        height: 20,
                        width: 20,
                      ),
                    const SizedBox(width: 12),
                    Text(
                      authenticationType.getTitle(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                        color: Colors.white.withValues(
                          alpha: isLoading ? 0.7 : 0.95,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
