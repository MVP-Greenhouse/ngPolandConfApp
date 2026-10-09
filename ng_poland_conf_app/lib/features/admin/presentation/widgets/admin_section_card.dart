import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/theme/app_palette.dart';

/// Shared surface card used on admin detail screens (matches hub radius/accent).
class AdminSectionCard extends StatelessWidget {
  const AdminSectionCard({
    super.key,
    required this.child,
    this.title,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final String? title;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return Material(
      color: Colors.transparent,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: palette.card,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: palette.hairline),
        ),
        child: Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (title case final sectionTitle?) ...[
                Text(
                  sectionTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: palette.onCard,
                  ),
                ),
                const SizedBox(height: 12),
              ],
              child,
            ],
          ),
        ),
      ),
    );
  }
}

/// Admin switch with brand pink track (avoids dark near-white [ColorScheme.primary]).
class AdminSwitchListTile extends StatelessWidget {
  const AdminSwitchListTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.contentPadding = EdgeInsets.zero,
  });

  final Widget title;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final EdgeInsetsGeometry contentPadding;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return SwitchListTile(
      contentPadding: contentPadding,
      title: title,
      value: value,
      onChanged: onChanged,
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return palette.onAccent;
        return palette.muted;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return palette.accent;
        return palette.panel;
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return Colors.transparent;
        return palette.hairline;
      }),
    );
  }
}

class AdminCompactChip extends StatelessWidget {
  const AdminCompactChip({super.key, required this.label, this.filled = false});

  final String label;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Chip(
      label: Text(label),
      labelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: filled ? palette.accent : palette.muted,
      ),
      backgroundColor: filled
          ? palette.accent.withValues(alpha: 0.16)
          : palette.panel,
      side: BorderSide(color: filled ? Colors.transparent : palette.hairline),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.zero,
      labelPadding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}
