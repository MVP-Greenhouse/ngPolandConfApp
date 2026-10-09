import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/widgets/admin_section_card.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/event_vote_ranking.dart';

class AdminVotingSection extends StatelessWidget {
  const AdminVotingSection({
    super.key,
    required this.config,
    required this.ranking,
    this.rankingTitle = 'Talk ranking',
    required this.onEnabledChanged,
    required this.onStartChanged,
    required this.onEndChanged,
    required this.onEndNow,
    required this.onTop5EnabledChanged,
  });

  final TrackEngagementConfig config;
  final List<EventVoteRank> ranking;
  final String rankingTitle;
  final ValueChanged<bool> onEnabledChanged;
  final ValueChanged<DateTime> onStartChanged;
  final ValueChanged<DateTime> onEndChanged;
  final VoidCallback onEndNow;
  final ValueChanged<bool> onTop5EnabledChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AdminSectionCard(
          title: 'Voting settings',
          child: Column(
            children: [
              AdminSwitchListTile(
                title: Text(
                  'Voting enabled',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 16,
                    color: scheme.onSurface,
                  ),
                ),
                value: config.votingEnabled,
                onChanged: onEnabledChanged,
              ),
              AdminDateTimeTile(
                label: 'Od',
                value: config.votingStartsAt,
                onPicked: onStartChanged,
              ),
              AdminDateTimeTile(
                label: 'Do',
                value: config.votingEndsAt,
                onPicked: onEndChanged,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: FilledButton.icon(
                  onPressed: onEndNow,
                  style: FilledButton.styleFrom(
                    backgroundColor: scheme.error,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.stop_circle_outlined),
                  label: const Text('End now'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        AdminSectionCard(
          title: 'Top 5 na schedule',
          child: AdminSwitchListTile(
            title: Text(
              'Top 5 enabled',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: 16,
                color: scheme.onSurface,
              ),
            ),
            value: config.top5Enabled,
            onChanged: onTop5EnabledChanged,
          ),
        ),
        const SizedBox(height: 12),
        AdminSectionCard(
          title: rankingTitle,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: ranking.isEmpty
              ? Text(
                  'No votes in this track',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 14,
                    color: scheme.onSurface.withValues(alpha: 0.6),
                  ),
                )
              : Column(
                  children: [
                    for (var i = 0; i < ranking.length; i++) ...[
                      if (i > 0)
                        Divider(
                          height: 1,
                          color: scheme.outline.withValues(alpha: 0.15),
                        ),
                      _RankingRow(rank: ranking[i]),
                    ],
                  ],
                ),
        ),
      ],
    );
  }
}

class _RankingRow extends StatelessWidget {
  const _RankingRow({required this.rank});

  final EventVoteRank rank;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rank.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: scheme.onSurface,
                    height: 1.25,
                  ),
                ),
                if (rank.speakerName.isNotEmpty)
                  Text(
                    rank.speakerName,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: scheme.onSurface.withValues(alpha: 0.65),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          _VoteCount(
            icon: Icons.thumb_up_alt_outlined,
            count: rank.likes,
            color: scheme.secondary,
          ),
        ],
      ),
    );
  }
}

class _VoteCount extends StatelessWidget {
  const _VoteCount({
    required this.icon,
    required this.count,
    required this.color,
  });

  final IconData icon;
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(
          '$count',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

class AdminDateTimeTile extends StatelessWidget {
  const AdminDateTimeTile({
    super.key,
    required this.label,
    required this.value,
    required this.onPicked,
  });

  final String label;
  final DateTime value;
  final ValueChanged<DateTime> onPicked;

  static final _format = DateFormat('yyyy-MM-dd HH:mm');

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final unset = value.millisecondsSinceEpoch == 0;
    return InkWell(
      onTap: () => _pick(context),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            SizedBox(
              width: 36,
              child: Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 14,
                  color: scheme.onSurface.withValues(alpha: 0.65),
                ),
              ),
            ),
            Expanded(
              child: Text(
                unset ? '—' : _format.format(value.toLocal()),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: scheme.onSurface,
                ),
              ),
            ),
            Icon(
              Icons.event,
              size: 18,
              color: scheme.onSurface.withValues(alpha: 0.45),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pick(BuildContext context) async {
    final local = value.millisecondsSinceEpoch == 0
        ? DateTime.now()
        : value.toLocal();
    final date = await showDatePicker(
      context: context,
      initialDate: local,
      firstDate: DateTime(2018),
      lastDate: DateTime(2100),
    );
    if (date == null || !context.mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(local),
    );
    if (time == null) return;
    onPicked(DateTime(date.year, date.month, date.day, time.hour, time.minute));
  }
}
