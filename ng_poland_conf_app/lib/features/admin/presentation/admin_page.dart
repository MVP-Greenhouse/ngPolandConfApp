import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/admin_voting_page.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/cubit/admin_cubit.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/logic/admin_hub_status.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/features/settings/presentation/connection_status.dart';
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
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, AdminState state) {
    if (!state.isAdmin) {
      return const SizedBox.shrink();
    }
    if (state.loading) {
      return const Center(child: CircularProgressIndicator());
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
          iconBackground: _votingIconBackground(context),
          accentColor: _accentColor(context),
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

  static Color _accentColor(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Theme.of(context).brightness == Brightness.dark
        ? scheme.primaryContainer
        : scheme.secondary;
  }

  static Color _votingIconBackground(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (Theme.of(context).brightness == Brightness.dark) {
      return scheme.secondaryContainer.withValues(alpha: 0.35);
    }
    return scheme.primary.withValues(alpha: 0.12);
  }
}

class AdminHubNavCard extends StatelessWidget {
  const AdminHubNavCard({
    super.key,
    required this.title,
    required this.icon,
    required this.iconBackground,
    required this.accentColor,
    required this.chips,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final Color iconBackground;
  final Color accentColor;
  final List<Widget> chips;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: scheme.outline.withValues(alpha: isDark ? 0.28 : 0.12),
            ),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(width: 4, color: accentColor),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: iconBackground,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(icon, size: 20, color: scheme.onSurface),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                title,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: scheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(spacing: 6, runSpacing: 6, children: chips),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: scheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ],
                    ),
                  ),
                ),
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
    final scheme = Theme.of(context).colorScheme;
    if (filled) {
      return Chip(
        label: Text(label),
        labelStyle: TextStyle(fontSize: 12, color: scheme.onPrimaryContainer),
        backgroundColor: scheme.primaryContainer,
        side: BorderSide.none,
        visualDensity: VisualDensity.compact,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.zero,
        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
      );
    }
    return Chip(
      label: Text(label),
      labelStyle: TextStyle(
        fontSize: 12,
        color: scheme.onSurface.withValues(alpha: 0.7),
      ),
      backgroundColor: Colors.transparent,
      side: BorderSide(color: scheme.outline.withValues(alpha: 0.35)),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.zero,
      labelPadding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}
