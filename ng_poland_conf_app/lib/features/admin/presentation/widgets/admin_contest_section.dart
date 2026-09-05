import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/widgets/admin_contest_history_section.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/widgets/admin_voting_section.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/widgets/start_new_contest_dialog.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_history_entry.dart';
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
    required this.history,
    required this.onNameChanged,
    required this.onEnabledChanged,
    required this.onStartChanged,
    required this.onEndChanged,
    required this.onDraw,
    required this.onFinish,
    required this.onStartNewContest,
  });

  final EngagementConfig config;
  final List<ContestParticipant> participants;
  final List<ContestWinner> winners;
  final List<ContestHistoryEntry> history;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<bool> onEnabledChanged;
  final ValueChanged<DateTime> onStartChanged;
  final ValueChanged<DateTime> onEndChanged;
  final ValueChanged<int> onDraw;
  final VoidCallback onFinish;
  final Future<void> Function({
    required String name,
    required bool carryParticipants,
  })
  onStartNewContest;

  @override
  State<AdminContestSection> createState() => _AdminContestSectionState();
}

class _AdminContestSectionState extends State<AdminContestSection> {
  late final TextEditingController _countController;
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _countController = TextEditingController(text: '1');
    _nameController = TextEditingController(text: widget.config.contestName);
  }

  @override
  void didUpdateWidget(covariant AdminContestSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.config.contestName != widget.config.contestName &&
        _nameController.text != widget.config.contestName) {
      _nameController.text = widget.config.contestName;
    }
  }

  @override
  void dispose() {
    _countController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  int get _count {
    return int.tryParse(_countController.text.trim()) ?? 1;
  }

  Future<void> _showStartNewContestDialog() async {
    final result = await showDialog<StartNewContestResult>(
      context: context,
      builder: (_) => const StartNewContestDialog(),
    );
    if (result == null) return;
    await widget.onStartNewContest(
      name: result.name,
      carryParticipants: result.carryParticipants,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final status = widget.config.contestStatus;
    final statusLabel =
        '${widget.config.contestEnabled ? 'włączone' : 'wyłączone'}'
        ' · ${status.name}'
        ' · ${widget.participants.length} zgłoszeń';
    String emailOrMissing(String email) =>
        email.trim().isEmpty ? 'brak danych' : email;

    return ExpansionTile(
      initiallyExpanded: false,
      tilePadding: EdgeInsets.zero,
      childrenPadding: const EdgeInsets.only(bottom: 8),
      shape: const Border(),
      collapsedShape: const Border(),
      title: Text('Konkurs', style: theme.textTheme.titleLarge),
      subtitle: Text(
        statusLabel,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
        ),
      ),
      children: [
        TextField(
          controller: _nameController,
          onChanged: widget.onNameChanged,
          decoration: const InputDecoration(labelText: 'Nazwa konkursu'),
        ),
        const SizedBox(height: 8),
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
            if (status == ContestStatus.finished)
              FilledButton(
                onPressed: _showStartNewContestDialog,
                child: const Text('Nowy konkurs'),
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
        AdminContestHistorySection(history: widget.history),
      ],
    );
  }
}
