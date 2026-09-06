import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/widgets/admin_section_card.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_history_entry.dart';

class AdminContestHistorySection extends StatelessWidget {
  const AdminContestHistorySection({super.key, required this.history});

  final List<ContestHistoryEntry> history;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return AdminSectionCard(
      padding: EdgeInsets.zero,
      child: Theme(
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: false,
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          shape: const Border(),
          collapsedShape: const Border(),
          title: Text(
            'Historia',
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: scheme.onSurface,
            ),
          ),
          children: [
            if (history.isEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  'Brak zakończonych konkursów',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 14,
                    color: scheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ),
            for (final entry in history)
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                childrenPadding: const EdgeInsets.only(left: 8, bottom: 8),
                shape: const Border(),
                collapsedShape: const Border(),
                title: Text(
                  entry.name,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontSize: 15,
                    color: scheme.onSurface,
                  ),
                ),
                subtitle: Text(
                  '${entry.winners.length} zwycięzców',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 13,
                    color: scheme.onSurface.withValues(alpha: 0.65),
                  ),
                ),
                children: [
                  if (entry.winners.isEmpty)
                    Text(
                      'Brak zwycięzców',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 13,
                        color: scheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  for (final winner in entry.winners)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: Text(
                        '${winner.order}. ${winner.displayName}',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontSize: 14,
                          color: scheme.onSurface,
                        ),
                      ),
                      subtitle: Text(
                        winner.email.trim().isEmpty
                            ? 'brak danych'
                            : winner.email,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          color: scheme.onSurface.withValues(alpha: 0.65),
                        ),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
