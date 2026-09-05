import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/admin_page.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/cubit/admin_cubit.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/widgets/admin_voting_section.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';
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
            title: const Text('Głosowanie'),
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, AdminState state) {
    if (!state.isAdmin) return const SizedBox.shrink();
    if (state.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final config = state.config ?? EngagementConfig.missing;
    final cubit = context.read<AdminCubit>();
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      children: [
        AdminVotingSection(
          config: config,
          ranking: state.ranking,
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
        ),
      ],
    );
  }
}
