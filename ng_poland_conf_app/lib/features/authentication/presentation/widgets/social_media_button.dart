import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/widgets/icon_with_darkmode.dart';

enum AuthenticationType {
  google,
  apple;

  String getIconAsset() => switch (this) {
        google => 'auth_with_google.png',
        apple => 'auth_with_apple.png',
      };

  String getTitle() => switch (this) {
        google => 'Sign in with Google',
        apple => 'Sign in with Apple',
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
    return SizedBox(
      height: 56,
      width: 300,
      child: IgnorePointer(
        ignoring: isLoading,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(
                  isLoading ? 0.65 : 0.85,
                ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconWithDarkMode(
                  imageName: authenticationType.getIconAsset(),
                  height: 24.0,
                  width: 24.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24.0,
                    right: 8.0,
                  ),
                  child: Text(
                    authenticationType.getTitle(),
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
