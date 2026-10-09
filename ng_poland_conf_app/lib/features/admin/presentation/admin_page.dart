import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/admin_voting_page.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/cubit/admin_cubit.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/logic/admin_hub_status.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/features/settings/presentation/connection_status.dart';
import 'package:ng_poland_conf_app/theme/app_palette.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';

class AdminPage extends StatelessWidget {
  static const path = '/admin';

  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
      color: Theme.of(context).colorScheme.inversePrimary,
    );

    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        return CustomScaffold(
          appBar: AppBar(
            title: Text('Admin', style: titleStyle),
            actions: const [ConnectionStatus()],
          ),
          body: ColoredBox(
            color: context.palette.screen,
            child: _buildBody(context, state),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, AdminState state) {
    if (!state.isAdmin) {
      return const SizedBox.shrink();
    }
    if (state.loading) {
      return Center(
        child: CircularProgressIndicator(color: context.palette.accent),
      );
    }

    final config =
        state.config?.forTrack(state.selectedTrack) ??
        TrackEngagementConfig.missing;
    return AdminHubContent(
      config: config,
      trackLabel: state.selectedTrack.label,
      onVotingTap: () => context.go(AdminVotingPage.path),
    );
  }
}

class AdminHubContent extends StatelessWidget {
  const AdminHubContent({
    super.key,
    required this.config,
    required this.onVotingTap,
    this.trackLabel,
  });

  final TrackEngagementConfig config;
  final VoidCallback onVotingTap;
  final String? trackLabel;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      children: [
        AdminHubNavCard(
          title: trackLabel == null ? 'Voting' : 'Voting · $trackLabel',
          icon: Icons.thumb_up_alt_outlined,
          chips: [
            _StatusChip(
              label: AdminHubStatus.votingSubtitle(config),
              filled: config.votingEnabled,
            ),
            _StatusChip(
              label: 'Top 5: ${AdminHubStatus.top5Subtitle(config)}',
              filled: config.top5Enabled,
            ),
          ],
          onTap: onVotingTap,
        ),
      ],
    );
  }
}

class AdminHubNavCard extends StatelessWidget {
  const AdminHubNavCard({
    super.key,
    required this.title,
    required this.icon,
    required this.chips,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final List<Widget> chips;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          decoration: BoxDecoration(
            color: palette.card,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: palette.hairline),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: palette.accent.withValues(alpha: 0.16),
                    shape: BoxShape.circle,
                  ),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(icon, size: 20, color: palette.accent),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: palette.onCard,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(spacing: 6, runSpacing: 6, children: chips),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: palette.muted),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label, required this.filled});

  final String label;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final labelStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: filled ? palette.accent : palette.muted,
    );
    return Chip(
      label: Text(label),
      labelStyle: labelStyle,
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
