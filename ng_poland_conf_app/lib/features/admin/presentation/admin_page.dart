import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/cubit/admin_cubit.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/widgets/admin_contest_section.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/widgets/admin_voting_section.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/features/settings/presentation/connection_status.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';

class AdminPage extends StatefulWidget {
  static const path = '/admin';

  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late final AdminCubit _cubit;
  String? _contestConfId;
  String? _contestId;
  String _contestName = '';

  @override
  void initState() {
    super.initState();
    _cubit = getIt.get<AdminCubit>();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
      color: Theme.of(context).colorScheme.inversePrimary,
    );

    return BlocConsumer<AdminCubit, AdminState>(
      bloc: _cubit,
      listenWhen: (previous, current) =>
          previous.message != current.message && current.message != null,
      listener: (context, state) {
        final message = state.message;
        if (message == null) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
        _cubit.clearMessage();
      },
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
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(AdminState state) {
    if (!state.isAdmin) {
      return const SizedBox.shrink();
    }
    if (state.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final config = state.config ?? EngagementConfig.missing;
    if (_contestConfId != state.latestConfId ||
        _contestId != config.contestId) {
      _contestConfId = state.latestConfId;
      _contestId = config.contestId;
      _contestName = config.contestName;
    }
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      children: [
        AdminVotingSection(
          config: config,
          ranking: state.ranking,
          onEnabledChanged: (enabled) => _cubit.saveVoting(
            enabled: enabled,
            start: config.votingStartsAt,
            end: config.votingEndsAt,
          ),
          onStartChanged: (start) => _cubit.saveVoting(
            enabled: config.votingEnabled,
            start: start,
            end: config.votingEndsAt,
          ),
          onEndChanged: (end) => _cubit.saveVoting(
            enabled: config.votingEnabled,
            start: config.votingStartsAt,
            end: end,
          ),
        ),
        const Divider(height: 1),
        AdminContestSection(
          config: config,
          participants: state.participants,
          winners: state.winners,
          history: state.history,
          onNameChanged: (name) => _contestName = name,
          onEnabledChanged: (enabled) => _cubit.saveContest(
            enabled: enabled,
            start: config.contestStartsAt,
            end: config.contestEndsAt,
            name: _contestName,
          ),
          onStartChanged: (start) => _cubit.saveContest(
            enabled: config.contestEnabled,
            start: start,
            end: config.contestEndsAt,
            name: _contestName,
          ),
          onEndChanged: (end) => _cubit.saveContest(
            enabled: config.contestEnabled,
            start: config.contestStartsAt,
            end: end,
            name: _contestName,
          ),
          onDraw: (count) => _cubit.draw(count: count, random: Random()),
          onFinish: _cubit.finishDrawing,
          onStartNewContest: _cubit.startNewContest,
        ),
      ],
    );
  }
}
