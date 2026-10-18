import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/core/presentation/theme/app_palette.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/connection_status.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/custom_scaffold.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/empty_list_info.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/home/presentation/widgets/track_navigation_bar.dart';
import 'package:ng_poland_conf_app/features/schedule/domain/entities/track_schedule.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/cubit/schedule_cubit.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/cubit/schedule_voting_banner_cubit.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/widgets/schedule_events_list.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/widgets/schedule_voting_banner.dart';

/// Agenda of a track. Expects a [ScheduleCubit] and a
/// [ScheduleVotingBannerCubit] above it.
class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  void _selectTrack(BuildContext context, EventItemType track) {
    context.read<ScheduleCubit>().selectTrack(track);
    context.read<ScheduleVotingBannerCubit>().load(track: track);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ScheduleCubit>().state;
    final banner = context.watch<ScheduleVotingBannerCubit>().state;
    final theme = Theme.of(context);
    final hasEvents = switch (state) {
      ScheduleLoaded(:final schedule) => schedule.events.isNotEmpty,
      _ => false,
    };

    return CustomScaffold(
      appBar: AppBar(
        bottom: switch (banner) {
          VotingBannerVisible(:final votingOpen, :final top5Enabled)
              when hasEvents =>
            PreferredSize(
              preferredSize: Size.fromHeight(
                ScheduleVotingBanner.barExtent(context),
              ),
              child: ColoredBox(
                color: context.palette.screen,
                child: ScheduleVotingBanner(
                  track: state.track,
                  votingOpen: votingOpen,
                  top5Enabled: top5Enabled,
                ),
              ),
            ),
          _ => null,
        },
        title: Text(
          'Schedule',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.inversePrimary,
          ),
        ),
        actions: const [ConnectionStatus()],
      ),
      body: switch (state) {
        ScheduleLoading() => const Center(child: CircularProgressIndicator()),
        ScheduleFailed() => const EmptyListInformation(),
        ScheduleLoaded(schedule: TrackSchedule(published: false, events: [])) =>
          const Center(child: Text('Agenda coming soon')),
        ScheduleLoaded(schedule: TrackSchedule(events: [])) =>
          const EmptyListInformation(),
        ScheduleLoaded(:final track, :final schedule) => ScheduleEventsList(
          listEvents: schedule.events,
          eventItemType: track,
        ),
      },
      showBottomNavigationBar: true,
      bottomNavigationBar: TrackNavigationBar(
        selectedType: state.track,
        onItemTapped: (track) => _selectTrack(context, track),
      ),
    );
  }
}
