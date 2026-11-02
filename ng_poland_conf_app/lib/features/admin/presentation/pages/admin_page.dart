import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/core/presentation/navigation/app_pages.dart';
import 'package:ng_poland_conf_app/core/presentation/theme/app_palette.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/connection_status.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/custom_scaffold.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/cubit/admin_cubit.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/pages/admin_voting_page.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/widgets/admin_section_card.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/widgets/admin_votable_events_sync.dart';

class AdminPage extends StatelessWidget {
  static const path = AppPaths.admin;

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
            child: _AdminHubBody(state: state),
          ),
        );
      },
    );
  }
}

class _AdminHubBody extends StatelessWidget {
  const _AdminHubBody({required this.state});

  final AdminState state;

  @override
  Widget build(BuildContext context) {
    if (!state.isAdmin) return const SizedBox.shrink();

    final confId = state.selectedConfId;
    return AdminHubContent(
      confId: confId,
      onVotingTap: () => context.go(AdminVotingPage.path),
      onSyncVotableEvents: confId == null
          ? null
          : context.read<AdminCubit>().syncVotableEvents,
    );
  }
}

class AdminHubContent extends StatelessWidget {
  const AdminHubContent({
    super.key,
    required this.onVotingTap,
    required this.onSyncVotableEvents,
    this.confId,
  });

  final VoidCallback onVotingTap;

  /// `null` disables the sync button.
  final VoidCallback? onSyncVotableEvents;
  final String? confId;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      children: [
        AdminSectionCard(
          title: 'Voting',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AdminHubNavRow(
                icon: Icons.thumb_up_alt_outlined,
                title: 'Settings & ranking',
                subtitle: 'Voting window, Top 5 and ranking per track',
                onTap: onVotingTap,
              ),
              const SizedBox(height: 8),
              Divider(height: 1, color: palette.hairline),
              const SizedBox(height: 16),
              AdminVotableEventsSync(
                confId: confId,
                onSync: onSyncVotableEvents,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Tappable row on the hub that opens an admin detail screen.
class AdminHubNavRow extends StatelessWidget {
  const AdminHubNavRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
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
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 16,
                      color: palette.onCard,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 14,
                      color: palette.muted,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: palette.muted),
          ],
        ),
      ),
    );
  }
}
