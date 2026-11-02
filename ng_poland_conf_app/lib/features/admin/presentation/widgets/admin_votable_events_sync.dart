import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/core/presentation/theme/app_palette.dart';

/// Rebuilds the list of talks that can be voted on in conference [confId].
class AdminVotableEventsSync extends StatelessWidget {
  const AdminVotableEventsSync({
    super.key,
    required this.confId,
    required this.onSync,
  });

  final String? confId;

  /// `null` disables the button.
  final VoidCallback? onSync;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final conference = confId == null ? 'this conference' : 'conference $confId';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Votable talks',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontSize: 16,
            color: palette.onCard,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Replaces the list of talks that can be voted on in $conference '
          'with the current agenda. A like is accepted only after that talk '
          'has ended.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 14,
            height: 1.35,
            color: palette.muted,
          ),
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerLeft,
          child: FilledButton.icon(
            onPressed: onSync,
            style: FilledButton.styleFrom(
              backgroundColor: palette.accent,
              foregroundColor: palette.onAccent,
            ),
            icon: const Icon(Icons.sync),
            label: const Text('Sync votable events'),
          ),
        ),
      ],
    );
  }
}
