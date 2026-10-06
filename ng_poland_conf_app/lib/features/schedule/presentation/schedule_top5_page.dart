import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/authentication_page.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/cubit/schedule_top5_cubit.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/widgets/schedule_top5_section.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/routing/routing.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';
import 'package:ng_poland_conf_app/widgets/empty_list_info.dart';

class ScheduleTop5Page extends StatefulWidget {
  const ScheduleTop5Page({super.key, required this.eventItemType});

  static const routeName = 'top5';
  static const routeNameKey = 'ScheduleTop5Page';
  static const pathSegment = 'top5';

  final String eventItemType;

  @override
  State<ScheduleTop5Page> createState() => _ScheduleTop5PageState();
}

class _ScheduleTop5PageState extends State<ScheduleTop5Page> {
  late final ScheduleTop5Cubit _cubit;
  late final EventItemType _track;

  @override
  void initState() {
    _track = EventItemType.values.firstWhere(
      (type) => type.name == widget.eventItemType,
      orElse: () => EventItemType.ngPoland,
    );
    _cubit = getIt.get<ScheduleTop5Cubit>()..load(track: _track);
    super.initState();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  Future<void> _onVote(String eventId) async {
    if (_cubit.requiresLogin) {
      if (!mounted) return;
      await context.push(
        AuthenticationPage.loginPath(
          from: internalLocationFromUri(GoRouterState.of(context).uri),
        ),
      );
      return;
    }
    try {
      await _cubit.toggleLike(eventId);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not save your vote')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
      color: Theme.of(context).colorScheme.inversePrimary,
      fontWeight: FontWeight.w700,
    );

    return CustomScaffold(
      showDrawer: false,
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: BlocBuilder<ScheduleTop5Cubit, ScheduleTop5State>(
          bloc: _cubit,
          builder: (context, state) {
            final subtitle = state.maybeWhen(
              empty: (track, confId, votingOpen, myLikedEventIds) =>
                  _subtitle(confId: confId, votingOpen: votingOpen),
              loaded: (top, track, confId, votingOpen, myLikedEventIds) =>
                  _subtitle(confId: confId, votingOpen: votingOpen),
              orElse: () => null,
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ranking Top 5', style: titleStyle),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      color: Theme.of(
                        context,
                      ).colorScheme.inversePrimary.withValues(alpha: 0.85),
                    ),
                  ),
              ],
            );
          },
        ),
        actions: [
          BlocBuilder<ScheduleTop5Cubit, ScheduleTop5State>(
            bloc: _cubit,
            builder: (context, state) {
              if (!state.isVotingOpen) return const SizedBox.shrink();
              return const Padding(
                padding: EdgeInsets.only(right: 12),
                child: _LiveBadge(),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ScheduleTop5Cubit, ScheduleTop5State>(
        bloc: _cubit,
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            hidden: () => const EmptyListInformation(),
            empty: (track, confId, votingOpen, myLikedEventIds) => ListView(
              padding: EdgeInsets.zero,
              children: [
                ScheduleTop5Section(
                  top: const [],
                  track: track,
                  votingOpen: votingOpen,
                  myLikedEventIds: myLikedEventIds,
                  onVote: _onVote,
                ),
              ],
            ),
            loaded: (top, track, confId, votingOpen, myLikedEventIds) =>
                ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ScheduleTop5Section(
                      top: top,
                      track: track,
                      votingOpen: votingOpen,
                      myLikedEventIds: myLikedEventIds,
                      onVote: _onVote,
                    ),
                  ],
                ),
            orElse: () => const EmptyListInformation(),
          );
        },
      ),
    );
  }

  static String _subtitle({
    required String confId,
    required bool votingOpen,
  }) {
    final confLabel = confId.isEmpty ? 'NG Poland' : 'NG Poland $confId';
    if (votingOpen) {
      return '$confLabel • Live voting';
    }
    return '$confLabel • Voting closed';
  }
}

class _LiveBadge extends StatelessWidget {
  const _LiveBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            'LIVE',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
              color: Colors.white,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
