import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ng_poland_conf_app/core/presentation/theme/app_palette.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/widgets/admin_section_card.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/services/event_vote_ranking.dart';

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
    final palette = context.palette;
    final titleStyle = Theme.of(
      context,
    ).textTheme.titleSmall?.copyWith(fontSize: 16, color: palette.onCard);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AdminSectionCard(
          title: 'Voting settings',
          child: Column(
            children: [
              AdminSwitchListTile(
                title: Text('Voting enabled', style: titleStyle),
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
                    backgroundColor: Theme.of(context).colorScheme.error,
                    foregroundColor: palette.onAccent,
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
            title: Text('Top 5 enabled', style: titleStyle),
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
                    color: palette.muted,
                  ),
                )
              : Column(
                  children: [
                    for (var i = 0; i < ranking.length; i++) ...[
                      if (i > 0) Divider(height: 1, color: palette.hairline),
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
    final palette = context.palette;
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
                    color: palette.onCard,
                    height: 1.25,
                  ),
                ),
                if (rank.speakerName.isNotEmpty)
                  Text(
                    rank.speakerName,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: palette.muted),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          _VoteCount(
            icon: Icons.thumb_up_alt_outlined,
            count: rank.likes,
            color: palette.accent,
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
            color: context.palette.onCard,
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

  /// Range offered by the picker; the app's first edition is 2018.
  static final _firstPickableDate = DateTime(2018);
  static final _lastPickableDate = DateTime(2100);

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final unset = TrackEngagementConfig.isUnset(value);
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
                  color: palette.muted,
                ),
              ),
            ),
            Expanded(
              child: Text(
                unset ? '—' : _format.format(value.toLocal()),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: palette.onCard,
                ),
              ),
            ),
            Icon(Icons.event, size: 18, color: palette.muted),
          ],
        ),
      ),
    );
  }

  Future<void> _pick(BuildContext context) async {
    final local = TrackEngagementConfig.isUnset(value)
        ? DateTime.now()
        : value.toLocal();
    final date = await showDatePicker(
      context: context,
      initialDate: local,
      firstDate: _firstPickableDate,
      lastDate: _lastPickableDate,
      builder: (context, child) => _PickerTheme(child: child),
    );
    if (date == null || !context.mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(local),
      builder: (context, child) => _PickerTheme(child: child),
    );
    if (time == null) return;
    onPicked(DateTime(date.year, date.month, date.day, time.hour, time.minute));
  }
}

/// Applies the app palette to the date and time pickers.
class _PickerTheme extends StatelessWidget {
  const _PickerTheme({required this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: palette.accent,
          onPrimary: palette.onAccent,
          surface: palette.card,
          onSurface: palette.onCard,
        ),
      ),
      child: child ?? const SizedBox.shrink(),
    );
  }
}
