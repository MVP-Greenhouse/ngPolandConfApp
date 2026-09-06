import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/logic/admin_hub_status.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/widgets/admin_contest_history_section.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/widgets/admin_section_card.dart';
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

  InputDecoration _fieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final status = widget.config.contestStatus;
    final canDraw = status != ContestStatus.finished;
    String emailOrMissing(String email) =>
        email.trim().isEmpty ? 'brak danych' : email;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AdminSectionCard(
          title: 'Ustawienia',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nameController,
                onChanged: widget.onNameChanged,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 15,
                  color: scheme.onSurface,
                ),
                decoration: _fieldDecoration('Nazwa konkursu'),
              ),
              const SizedBox(height: 8),
              AdminSwitchListTile(
                title: Text(
                  'Włączone',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontSize: 16,
                    color: scheme.onSurface,
                  ),
                ),
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
              const SizedBox(height: 4),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  AdminCompactChip(
                    label: AdminHubStatus.enabledLabel(
                      widget.config.contestEnabled,
                    ),
                    filled: widget.config.contestEnabled,
                  ),
                  AdminCompactChip(
                    label: AdminHubStatus.contestStatusLabel(status),
                  ),
                  AdminCompactChip(
                    label: AdminHubStatus.participantChipLabel(
                      widget.participants.length,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        AdminSectionCard(
          title: 'Losowanie',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _countController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 15,
                  color: scheme.onSurface,
                ),
                decoration: _fieldDecoration('Ile wylosować'),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilledButton(
                    onPressed: canDraw ? () => widget.onDraw(_count) : null,
                    child: const Text('Losuj N'),
                  ),
                  FilledButton(
                    onPressed: canDraw ? () => widget.onDraw(1) : null,
                    child: const Text('Losuj 1'),
                  ),
                  FilledButton(
                    onPressed: status == ContestStatus.drawing
                        ? widget.onFinish
                        : null,
                    child: const Text('Zakończ losowanie'),
                  ),
                  if (status == ContestStatus.finished)
                    FilledButton.icon(
                      onPressed: _showStartNewContestDialog,
                      style: FilledButton.styleFrom(
                        backgroundColor: scheme.primaryContainer,
                        foregroundColor: Colors.white,
                      ),
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('Nowy konkurs'),
                    ),
                ],
              ),
            ],
          ),
        ),
        if (widget.winners.isNotEmpty) ...[
          const SizedBox(height: 12),
          AdminSectionCard(
            title: 'Wylosowani',
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              children: [
                for (var i = 0; i < widget.winners.length; i++) ...[
                  if (i > 0)
                    Divider(
                      height: 1,
                      color: scheme.outline.withValues(alpha: 0.15),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: scheme.primaryContainer.withValues(
                              alpha: 0.25,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${widget.winners[i].order}',
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: scheme.onSurface,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.winners[i].displayName,
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: scheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                emailOrMissing(widget.winners[i].email),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontSize: 13,
                                  color: scheme.onSurface.withValues(
                                    alpha: 0.65,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
        const SizedBox(height: 12),
        AdminContestHistorySection(history: widget.history),
      ],
    );
  }
}
