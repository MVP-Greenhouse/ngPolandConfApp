import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/admin_page.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/cubit/admin_cubit.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/widgets/admin_contest_section.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';

class AdminContestPage extends StatefulWidget {
  const AdminContestPage({super.key});

  static const path = '/admin/contest';

  @override
  State<AdminContestPage> createState() => _AdminContestPageState();
}

class _AdminContestPageState extends State<AdminContestPage> {
  String? _contestConfId;
  String? _contestId;
  String _contestName = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        return CustomScaffold(
          appBar: AppBar(
            leading: BackButton(onPressed: () => context.go(AdminPage.path)),
            title: const Text('Konkurs'),
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
    if (_contestConfId != state.latestConfId ||
        _contestId != config.contestId) {
      _contestConfId = state.latestConfId;
      _contestId = config.contestId;
      _contestName = config.contestName;
    }
    final cubit = context.read<AdminCubit>();

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      children: [
        AdminContestSection(
          config: config,
          participants: state.participants,
          winners: state.winners,
          history: state.history,
          onNameChanged: (name) => _contestName = name,
          onEnabledChanged: (enabled) => cubit.saveContest(
            enabled: enabled,
            start: config.contestStartsAt,
            end: config.contestEndsAt,
            name: _contestName,
          ),
          onStartChanged: (start) => cubit.saveContest(
            enabled: config.contestEnabled,
            start: start,
            end: config.contestEndsAt,
            name: _contestName,
          ),
          onEndChanged: (end) => cubit.saveContest(
            enabled: config.contestEnabled,
            start: config.contestStartsAt,
            end: end,
            name: _contestName,
          ),
          onDraw: (count) => cubit.draw(count: count, random: Random()),
          onFinish: cubit.finishDrawing,
          onStartNewContest: cubit.startNewContest,
        ),
      ],
    );
  }
}
