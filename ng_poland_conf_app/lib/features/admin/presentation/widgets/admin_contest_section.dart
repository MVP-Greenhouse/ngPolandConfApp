import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/widgets/admin_voting_section.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_participant.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_status.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_winner.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';

class AdminContestSection extends StatefulWidget {
  const AdminContestSection({
    super.key,
    required this.config,
    required this.participants,
    required this.winners,
    required this.onEnabledChanged,
    required this.onStartChanged,
    required this.onEndChanged,
    required this.onDraw,
    required this.onFinish,
  });

  final EngagementConfig config;
  final List<ContestParticipant> participants;
  final List<ContestWinner> winners;
  final ValueChanged<bool> onEnabledChanged;
  final ValueChanged<DateTime> onStartChanged;
  final ValueChanged<DateTime> onEndChanged;
  final ValueChanged<int> onDraw;
  final VoidCallback onFinish;

  @override
  State<AdminContestSection> createState() => _AdminContestSectionState();
}

class _AdminContestSectionState extends State<AdminContestSection> {
  late final TextEditingController _countController;

  @override
  void initState() {
    super.initState();
    _countController = TextEditingController(text: '1');
  }

  @override
  void dispose() {
    _countController.dispose();
    super.dispose();
  }

  int get _count {
    return int.tryParse(_countController.text.trim()) ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    final status = widget.config.contestStatus;
    String emailOrMissing(String email) =>
        email.trim().isEmpty ? 'brak danych' : email;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Konkurs', style: Theme.of(context).textTheme.titleLarge),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Włączone'),
          value: widget.config.contestEnabled,
          onChanged: widget.onEnabledChanged,
        ),
        AdminDateTimeTile(
          label: 'Od',
          value: widget.config.contestStartsAt,
          onPicked: widget.onStartChanged,
        ),
        AdminDateTimeTile(
          label: 'Do',
          value: widget.config.contestEndsAt,
          onPicked: widget.onEndChanged,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Chip(
            label: Text(
              '${status.name} · ${widget.participants.length} zgłoszeń',
            ),
          ),
        ),
        TextField(
          controller: _countController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(labelText: 'Ile wylosować'),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilledButton(
              onPressed: () => widget.onDraw(_count),
              child: const Text('Losuj N'),
            ),
            FilledButton.tonal(
              onPressed: () => widget.onDraw(1),
              child: const Text('Losuj 1'),
            ),
            FilledButton(
              onPressed: status == ContestStatus.drawing
                  ? widget.onFinish
                  : null,
              child: const Text('Zakończ losowanie'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final winner in widget.winners)
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              '${winner.order}. ${winner.displayName} · ${emailOrMissing(winner.email)}',
            ),
          ),
      ],
    );
  }
}
