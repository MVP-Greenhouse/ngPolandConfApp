import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/admin_page.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/cubit/admin_cubit.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/widgets/admin_section_card.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/widgets/admin_voting_section.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/widgets/custom_dropdown.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';

class AdminVotingPage extends StatelessWidget {
  const AdminVotingPage({super.key});

  static const path = '/admin/voting';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        return CustomScaffold(
          appBar: AppBar(
            leading: BackButton(onPressed: () => context.go(AdminPage.path)),
            title: Text(
              'Voting',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            actions: [
              if (state.confIds.isNotEmpty && state.selectedConfId != null)
                CustomDropDown(
                  options: state.confIds,
                  selectedOption: state.selectedConfId!,
                  tooltip: 'Select conference',
                  onChanged: (confId) {
                    if (confId != null) {
                      context.read<AdminCubit>().selectConference(confId);
                    }
                  },
                ),
            ],
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Future<void> _confirmEndNow(BuildContext context, AdminCubit cubit) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('End voting?'),
        content: const Text(
          'Voting will close immediately (window end = now).',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Anuluj'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('End now'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await cubit.endVotingNow();
    }
  }

  Widget _buildBody(BuildContext context, AdminState state) {
    if (!state.isAdmin) return const SizedBox.shrink();
    if (state.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final config =
        state.config?.forTrack(state.selectedTrack) ??
        TrackEngagementConfig.missing;
    final cubit = context.read<AdminCubit>();
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      children: [
        if (state.selectedConfId != null) ...[
          AdminSectionCard(
            title: 'Konferencja',
            child: Text(
              'Edytujesz ${state.selectedTrack.label} / ${state.selectedConfId}'
              '${state.selectedConfId == state.latestConfId ? ' (najnowsza)' : ''}.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(
                  alpha: 0.8,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
        if (state.availableTracks.isNotEmpty) ...[
          AdminSectionCard(
            title: 'Track / rodzaj eventu',
            child: SegmentedButton<EventItemType>(
              segments: [
                for (final track in state.availableTracks)
                  ButtonSegment<EventItemType>(
                    value: track,
                    tooltip: track.label,
                    icon: Image.asset(
                      track.imagePath,
                      height: 28,
                      width: 28,
                      fit: BoxFit.contain,
                    ),
                  ),
              ],
              selected: {state.selectedTrack},
              onSelectionChanged: (selection) {
                if (selection.isNotEmpty) {
                  cubit.selectTrack(selection.first);
                }
              },
              style: const ButtonStyle(
                visualDensity: VisualDensity.comfortable,
                padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
        AdminVotingSection(
          config: config,
          ranking: state.ranking,
          rankingTitle: 'Ranking — ${state.selectedTrack.label}',
          onEnabledChanged: (enabled) => cubit.saveVoting(
            enabled: enabled,
            start: config.votingStartsAt,
            end: config.votingEndsAt,
          ),
          onStartChanged: (start) => cubit.saveVoting(
            enabled: config.votingEnabled,
            start: start,
            end: config.votingEndsAt,
          ),
          onEndChanged: (end) => cubit.saveVoting(
            enabled: config.votingEnabled,
            start: config.votingStartsAt,
            end: end,
          ),
          onEndNow: () => _confirmEndNow(context, cubit),
          onTop5EnabledChanged: cubit.saveTop5Enabled,
        ),
      ],
    );
  }
}
