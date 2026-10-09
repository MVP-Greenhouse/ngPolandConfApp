import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/core/mixins/connectivity_mixin.dart';
import 'package:ng_poland_conf_app/features/edition/domains/logic/edition_projections.dart';
import 'package:ng_poland_conf_app/features/edition/presentation/edition_cubit.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/cubit/schedule_cubit.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/cubit/schedule_voting_banner_cubit.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/widgets/schedule_events_list.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/widgets/schedule_voting_banner.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/theme/app_palette.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';
import 'package:ng_poland_conf_app/widgets/empty_list_info.dart';

import '../../../widgets/confs_bottom_nav_bar.dart';
import '../../settings/presentation/connection_status.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key, this.initialTrack});

  final EventItemType? initialTrack;

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> with ConnectivityMixin {
  late final ScheduleCubit _cubit;
  late final ScheduleVotingBannerCubit _bannerCubit;
  late EventItemType _eventItemType;

  @override
  void initState() {
    _cubit = getIt.get<ScheduleCubit>();
    _bannerCubit = getIt.get<ScheduleVotingBannerCubit>();
    _eventItemType = widget.initialTrack ?? EventItemType.ngPoland;

    _cubit.getListEvents(eventItemType: _eventItemType);
    _bannerCubit.load(track: _eventItemType);
    super.initState();
  }

  @override
  void dispose() {
    _bannerCubit.close();
    super.dispose();
  }

  void onEventItemTabChange(EventItemType type) {
    setState(() => _eventItemType = type);
    _cubit.getListEvents(eventItemType: _eventItemType);
    _bannerCubit.load(track: type);
  }

  PreferredSizeWidget? _bannerBottom(ScheduleVotingBannerState bannerState) {
    return bannerState.maybeWhen(
      visible: (votingOpen, top5Enabled) => PreferredSize(
        preferredSize: Size.fromHeight(ScheduleVotingBanner.barExtent(context)),
        child: ColoredBox(
          color: context.palette.screen,
          child: ScheduleVotingBanner(
            track: _eventItemType,
            votingOpen: votingOpen,
            top5Enabled: top5Enabled,
          ),
        ),
      ),
      orElse: () => null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleVotingBannerCubit, ScheduleVotingBannerState>(
      bloc: _bannerCubit,
      builder: (context, bannerState) {
        return BlocBuilder<ScheduleCubit, ScheduleState>(
          bloc: _cubit,
          builder: (context, state) {
            final hasEvents = state.maybeWhen(
              loaded: (listEvents) => listEvents.isNotEmpty,
              orElse: () => false,
            );
            return CustomScaffold(
              appBar: AppBar(
                bottom: hasEvents ? _bannerBottom(bannerState) : null,
                title: Text(
                  'Schedule',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                actions: const [ConnectionStatus()],
              ),
              body: state.maybeWhen(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error) => const EmptyListInformation(),
                loaded: (listEvents) {
                  if (listEvents.isEmpty) {
                    final edition = getIt.get<EditionCubit>().current;
                    final day = edition == null
                        ? null
                        : conferenceDayForTrack(edition, _eventItemType);
                    if (day != null && !day.published) {
                      return const Center(child: Text('Agenda coming soon'));
                    }
                    return const EmptyListInformation();
                  }
                  return ScheduleEventsList(
                    listEvents: listEvents,
                    eventItemType: _eventItemType,
                  );
                },
                orElse: () => const SizedBox.shrink(),
              ),
              showBottomNavigationBar: true,
              bottomNavigationBar: ConfsBottomNavigationBar(
                selectedType: _eventItemType,
                onItemTapped: onEventItemTabChange,
              ),
            );
          },
        );
      },
    );
  }
}
