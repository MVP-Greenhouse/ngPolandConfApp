import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/services/email_address.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/widgets/auth_ui_tokens.dart';

class MagicLinkForm extends HookWidget {
  const MagicLinkForm({
    super.key,
    required this.isLoading,
    required this.onSubmit,
    this.initialEmail = '',
    this.linkSent = false,
  });

  final bool isLoading;
  final ValueChanged<String> onSubmit;
  final String initialEmail;
  final bool linkSent;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initialEmail);
    final validationError = useState<String?>(null);
    final focused = useState(false);
    useEffect(() {
      if (initialEmail.isNotEmpty && controller.text.isEmpty) {
        controller.text = initialEmail;
      }
      return null;
    }, [initialEmail]);

    void submit() {
      final email = controller.text.trim();
      if (!isValidEmailAddress(email)) {
        validationError.value = 'Enter a valid email address.';
        return;
      }
      validationError.value = null;
      onSubmit(email);
    }

    final typedEmail = controller.text.trim();
    final accent = Theme.of(context).colorScheme.secondary;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AuthUiTokens.cardBg,
        borderRadius: .circular(16),
        border: .all(color: accent.withValues(alpha: 0.22)),
        boxShadow: AuthUiTokens.cardShadow(accent),
      ),
      child: Padding(
        padding: const .all(20),
        child: linkSent
            ? _MagicLinkSentContent(
                emailDisplay: typedEmail.isNotEmpty ? typedEmail : initialEmail,
                isLoading: isLoading,
                onResend: submit,
              )
            : _MagicLinkComposeContent(
                controller: controller,
                isLoading: isLoading,
                focused: focused.value,
                validationError: validationError.value,
                onFocusChange: (value) => focused.value = value,
                onSubmit: submit,
              ),
      ),
    );
  }
}

class _MagicLinkSentContent extends StatelessWidget {
  const _MagicLinkSentContent({
    required this.emailDisplay,
    required this.isLoading,
    required this.onResend,
  });

  final String emailDisplay;
  final bool isLoading;
  final VoidCallback onResend;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.mark_email_read_rounded, color: scheme.secondary),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Check your inbox',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurface,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'We sent a sign-in link to $emailDisplay.',
          style: TextStyle(
            fontSize: 13,
            height: 1.35,
            color: scheme.onSurface.withValues(alpha: 0.85),
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: isLoading ? null : onResend,
          child: const Text('Resend'),
        ),
      ],
    );
  }
}

class _MagicLinkComposeContent extends StatelessWidget {
  const _MagicLinkComposeContent({
    required this.controller,
    required this.isLoading,
    required this.focused,
    required this.validationError,
    required this.onFocusChange,
    required this.onSubmit,
  });

  final TextEditingController controller;
  final bool isLoading;
  final bool focused;
  final String? validationError;
  final ValueChanged<bool> onFocusChange;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = scheme.secondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Attendee email',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Colors.white.withValues(alpha: 0.95),
          ),
        ),
        const SizedBox(height: 10),
        Focus(
          onFocusChange: onFocusChange,
          child: TextField(
            key: const ValueKey('magic_link_email_field'),
            controller: controller,
            enabled: !isLoading,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            cursorColor: accent,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: AuthUiTokens.fieldBg,
              hintText: 'you@example.com',
              hintStyle: TextStyle(
                color: Colors.white.withValues(alpha: 0.45),
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              errorText: validationError,
              prefixIcon: Icon(
                Icons.mail_outline_rounded,
                color: focused ? accent : accent.withValues(alpha: 0.85),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AuthUiTokens.fieldBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AuthUiTokens.fieldBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: accent, width: 1.4),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: scheme.error),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: scheme.error, width: 1.4),
              ),
            ),
            onSubmitted: (_) => onSubmit(),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.verified_user_rounded, size: 16, color: accent),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                'We’ll send a secure, password-free link for quick sign-in.',
                style: TextStyle(
                  fontSize: 12,
                  height: 1.4,
                  color: Colors.white.withValues(alpha: 0.72),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: 0.45),
                blurRadius: 22,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: SizedBox(
            height: 48,
            width: double.infinity,
            child: FilledButton(
              key: const ValueKey('magic_link_submit_button'),
              onPressed: isLoading ? null : onSubmit,
              style: FilledButton.styleFrom(
                backgroundColor: accent,
                foregroundColor: Colors.white,
                disabledBackgroundColor: accent.withValues(alpha: 0.45),
                disabledForegroundColor: Colors.white70,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Send Magic Link',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(Icons.bolt_rounded, size: 20),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
