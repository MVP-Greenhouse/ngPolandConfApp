import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/cubit/schedule_cubit.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/widgets/event.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';

import '../../../widgets/confs_bottom_nav_bar.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  late final ScheduleCubit _cubit;
  final selectedTabItem = EventItemType.ngPoland;

  @override
  void initState() {
    _cubit = getIt.get<ScheduleCubit>();

    _cubit.getListEvents(
      eventItemType: EventItemType.ngPoland,
    );
    super.initState();
  }

  void onEventItemTabChange(int idx) {
    if (idx == 0) {
      _cubit.getListEvents(
        eventItemType: EventItemType.ngPoland,
      );
    } else {
      _cubit.getListEvents(
        eventItemType: EventItemType.jsPoland,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: BlocBuilder<ScheduleCubit, ScheduleState>(
        bloc: _cubit,
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (listEvents) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: ListView.builder(
                  itemCount: listEvents.length,
                  itemBuilder: (context, index) {
                    return ScheduleEvent(
                      listEvents[index],
                      Theme.of(context).colorScheme.tertiary,
                    );
                  }),
            ),
            orElse: SizedBox.shrink,
          );
        },
      ),
      showBottomNavigationBar: true,
      bottomNavigationBar: ConfsBottomNavigationBar(onItemTapped: onEventItemTabChange),
    );
  }
}
