import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/speaker_vote_ranking.dart';

class AdminVotingSection extends StatelessWidget {
  const AdminVotingSection({
    super.key,
    required this.config,
    required this.ranking,
    required this.onEnabledChanged,
    required this.onStartChanged,
    required this.onEndChanged,
  });

  final EngagementConfig config;
  final List<SpeakerVoteRank> ranking;
  final ValueChanged<bool> onEnabledChanged;
  final ValueChanged<DateTime> onStartChanged;
  final ValueChanged<DateTime> onEndChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Włączone'),
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
        const SizedBox(height: 8),
        for (final rank in ranking)
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(rank.name),
            trailing: Text('👍 ${rank.up}  👎 ${rank.down}'),
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
    final unset = value.millisecondsSinceEpoch == 0;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      subtitle: Text(unset ? '—' : _format.format(value.toLocal())),
      onTap: () => _pick(context),
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
