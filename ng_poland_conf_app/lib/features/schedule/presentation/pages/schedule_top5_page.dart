import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/core/presentation/navigation/redirect_paths.dart';
import 'package:ng_poland_conf_app/core/presentation/theme/app_palette.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/app_notice.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/custom_back_button.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/custom_scaffold.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/empty_list_info.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/cubit/schedule_top5_cubit.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/widgets/schedule_top5_section.dart';

/// Live Top 5 of a track. Expects a [ScheduleTop5Cubit] above it.
class ScheduleTop5Page extends StatelessWidget {
  const ScheduleTop5Page({super.key});

  static const routeName = 'top5';
  static const routeNameKey = 'ScheduleTop5Page';
  static const pathSegment = 'top5';

  Future<void> _onVote(BuildContext context, String eventId) async {
    final cubit = context.read<ScheduleTop5Cubit>();
    if (cubit.requiresLogin) {
      await context.push(
        loginPath(from: internalLocationFromUri(GoRouterState.of(context).uri)),
      );
      return;
    }
    final accepted = await cubit.toggleLike(eventId);
    if (!accepted && context.mounted) {
      showAppNotice(context, AppNotice.voteUnavailable);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ScheduleTop5Cubit>().state;
    final theme = Theme.of(context);
    final titleColor = theme.colorScheme.inversePrimary;
    final board = switch (state) {
      Top5Ready(:final board) => board,
      _ => null,
    };

    return CustomScaffold(
      showDrawer: false,
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              'Ranking Top 5',
              style: theme.textTheme.titleMedium?.copyWith(
                color: titleColor,
                fontWeight: .w700,
              ),
            ),
            if (board != null)
              Text(
                _subtitle(confId: board.confId, votingOpen: board.votingOpen),
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 12,
                  color: titleColor.withValues(alpha: 0.85),
                ),
              ),
          ],
        ),
        actions: [
          if (state.isVotingOpen)
            const Padding(padding: .only(right: 12), child: _LiveBadge()),
        ],
      ),
      body: ColoredBox(
        color: context.palette.screen,
        child: switch (state) {
          Top5StateLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
          Top5StateHidden() => const EmptyListInformation(),
          Top5Ready(:final board) => ListView(
            padding: .zero,
            children: [
              ScheduleTop5Section(
                top: board.top,
                track: board.track,
                votingOpen: board.votingOpen,
                myLikedEventIds: board.myVotes,
                onVote: (eventId) => _onVote(context, eventId),
              ),
            ],
          ),
        },
      ),
    );
  }

  static String _subtitle({required String confId, required bool votingOpen}) {
    final confLabel = confId.isEmpty ? 'NG Poland' : 'NG Poland $confId';
    return votingOpen
        ? '$confLabel • Live voting'
        : '$confLabel • Voting closed';
  }
}

class _LiveBadge extends StatelessWidget {
  const _LiveBadge();

  @override
  Widget build(BuildContext context) {
    final light = Theme.of(context).brightness == Brightness.light;
    final background = light
        ? context.palette.accent
        : Colors.white.withValues(alpha: 0.18);
    const foreground = Colors.white;

    return DecoratedBox(
      decoration: BoxDecoration(color: background, borderRadius: .circular(20)),
      child: Padding(
        padding: const .symmetric(horizontal: 10, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox.square(
              dimension: 7,
              child: DecoratedBox(
                decoration: BoxDecoration(color: foreground, shape: .circle),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              'LIVE',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
                color: foreground,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
