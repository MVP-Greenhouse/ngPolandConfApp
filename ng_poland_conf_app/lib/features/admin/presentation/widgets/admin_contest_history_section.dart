import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_history_entry.dart';

class AdminContestHistorySection extends StatelessWidget {
  const AdminContestHistorySection({super.key, required this.history});

  final List<ContestHistoryEntry> history;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: false,
      tilePadding: EdgeInsets.zero,
      childrenPadding: const EdgeInsets.only(bottom: 8),
      shape: const Border(),
      collapsedShape: const Border(),
      title: Text('Historia', style: Theme.of(context).textTheme.titleMedium),
      children: [
        if (history.isEmpty)
          const ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Brak zakończonych konkursów'),
          ),
        for (final entry in history)
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            childrenPadding: const EdgeInsets.only(left: 16, bottom: 8),
            shape: const Border(),
            collapsedShape: const Border(),
            title: Text(entry.name),
            subtitle: Text('${entry.winners.length} zwycięzców'),
            children: [
              if (entry.winners.isEmpty)
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Brak zwycięzców'),
                ),
              for (final winner in entry.winners)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('${winner.order}. ${winner.displayName}'),
                  subtitle: Text(
                    winner.email.trim().isEmpty ? 'brak danych' : winner.email,
                  ),
                ),
            ],
          ),
      ],
    );
  }
}
