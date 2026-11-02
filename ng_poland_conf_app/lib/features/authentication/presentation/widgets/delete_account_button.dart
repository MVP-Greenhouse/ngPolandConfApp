import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ng_poland_conf_app/core/presentation/theme/app_palette.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/app_notice.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_session.dart';

/// Small drawer button that deletes the account after a confirmation.
/// Shown only while signed in.
class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({
    super.key,
    required this.session,
    required this.onDelete,
    required this.onDeleted,
  });

  final UserSession session;

  /// Deletes the account; returns the message to show when it fails.
  final Future<String?> Function() onDelete;

  /// Called after the account was deleted and the notice is shown.
  final VoidCallback onDeleted;

  static const _deletedNotice = AppNotice(
    title: 'Your account was deleted',
    body: 'Your sign-in and profile have been removed.',
    tone: .success,
  );

  Future<void> _confirm(BuildContext context) async {
    final outcome = await showDialog<({String? error})>(
      context: context,
      builder: (_) => _DeleteAccountDialog(
        email: session.profile?.email ?? '',
        onDelete: onDelete,
      ),
    );
    if (outcome == null || !context.mounted) return;
    // Snackbars are drawn below the drawer, which would cover the notice.
    Scaffold.maybeOf(context)?.closeDrawer();
    if (outcome.error case final error?) {
      showAppNotice(
        context,
        AppNotice(
          title: "Your account wasn't deleted",
          body: error,
          tone: .error,
        ),
      );
      return;
    }
    showAppNotice(context, _deletedNotice);
    onDeleted();
  }

  @override
  Widget build(BuildContext context) {
    if (session is! SignedIn) return const SizedBox.shrink();

    final scheme = Theme.of(context).colorScheme;
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: scheme.error,
        textStyle: Theme.of(context).textTheme.labelSmall,
      ),
      onPressed: () => _confirm(context),
      child: const Text('Delete account'),
    );
  }
}

/// Pops `(error: null)` once deleted, `(error: message)` when it failed, and
/// `null` when cancelled.
class _DeleteAccountDialog extends HookWidget {
  const _DeleteAccountDialog({required this.email, required this.onDelete});

  final String email;
  final Future<String?> Function() onDelete;

  @override
  Widget build(BuildContext context) {
    final busy = useState(false);
    final scheme = Theme.of(context).colorScheme;
    final palette = context.palette;
    // Explicit sizes: the app theme's body text (28) is sized for pages.
    final buttonText = Theme.of(
      context,
    ).textTheme.labelLarge?.copyWith(fontSize: 14, fontWeight: .w600);

    Future<void> delete() async {
      busy.value = true;
      final error = await onDelete();
      if (context.mounted) Navigator.pop(context, (error: error));
    }

    return AlertDialog(
      backgroundColor: palette.card,
      shape: RoundedRectangleBorder(
        borderRadius: .circular(20),
        side: BorderSide(color: scheme.error.withValues(alpha: 0.35)),
      ),
      titlePadding: const .fromLTRB(20, 20, 20, 0),
      contentPadding: const .fromLTRB(20, 16, 20, 8),
      actionsPadding: const .fromLTRB(16, 8, 16, 16),
      title: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: scheme.error.withValues(alpha: 0.16),
              shape: .circle,
            ),
            child: SizedBox.square(
              dimension: 36,
              child: Icon(
                Icons.delete_forever_outlined,
                size: 20,
                color: scheme.error,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Delete your account?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: .w700,
                color: palette.onCard,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          const _Consequence(
            icon: Icons.person_off_outlined,
            text:
                'Your sign-in and profile in this app (name and email) are '
                'removed. Your Google or Apple account stays.',
          ),
          const SizedBox(height: 10),
          const _Consequence(
            icon: Icons.how_to_vote_outlined,
            text: 'Your votes stay in the counts, without your name.',
          ),
          const SizedBox(height: 10),
          // Google's account picker says the choice is for continuing to use
          // the app, and its wording can't be changed.
          _Consequence(
            icon: Icons.verified_user_outlined,
            text:
                "Next, you confirm it's you. If a list of accounts appears, "
                'choose ${email.isEmpty ? 'the one you signed in with' : email}, '
                "even if it says you'll keep using the app.",
          ),
          const SizedBox(height: 10),
          const _Consequence(
            icon: Icons.error_outline_rounded,
            text: "This can't be undone.",
            emphasized: true,
          ),
        ],
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: palette.muted,
            textStyle: buttonText,
          ),
          onPressed: busy.value ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: scheme.error,
            foregroundColor: palette.onAccent,
            textStyle: buttonText,
          ),
          onPressed: busy.value ? null : delete,
          child: busy.value
              ? SizedBox.square(
                  dimension: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: palette.onAccent,
                  ),
                )
              : const Text('Delete'),
        ),
      ],
    );
  }
}

/// One line of what deleting the account does.
class _Consequence extends StatelessWidget {
  const _Consequence({
    required this.icon,
    required this.text,
    this.emphasized = false,
  });

  final IconData icon;
  final String text;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final color = emphasized
        ? Theme.of(context).colorScheme.error
        : palette.muted;

    return Row(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: const .only(top: 1),
          child: Icon(icon, size: 18, color: color),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              height: 1.35,
              fontWeight: emphasized ? .w600 : .w400,
              color: emphasized ? palette.onCard : palette.muted,
            ),
          ),
        ),
      ],
    );
  }
}
