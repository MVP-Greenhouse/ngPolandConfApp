import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/admin_contest_page.dart';
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
            actions: [
              if (state.latestConfId != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Chip(label: Text(state.latestConfId!)),
                ),
              const ConnectionStatus(),
            ],
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

    final config = state.config ?? EngagementConfig.missing;
    return AdminHubContent(
      config: config,
      participantCount: state.participants.length,
      onVotingTap: () => context.go(AdminVotingPage.path),
      onContestTap: () => context.go(AdminContestPage.path),
    );
  }
}

class AdminHubContent extends StatelessWidget {
  const AdminHubContent({
    super.key,
    required this.config,
    required this.participantCount,
    required this.onVotingTap,
    required this.onContestTap,
  });

  final EngagementConfig config;
  final int participantCount;
  final VoidCallback onVotingTap;
  final VoidCallback onContestTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      children: [
        ListTile(
          title: const Text('Głosowanie'),
          subtitle: Text(AdminHubStatus.votingSubtitle(config)),
          trailing: const Icon(Icons.chevron_right),
          onTap: onVotingTap,
        ),
        ListTile(
          title: const Text('Konkurs'),
          subtitle: Text(
            AdminHubStatus.contestSubtitle(
              config: config,
              participantCount: participantCount,
            ),
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: onContestTap,
        ),
      ],
    );
  }
}
