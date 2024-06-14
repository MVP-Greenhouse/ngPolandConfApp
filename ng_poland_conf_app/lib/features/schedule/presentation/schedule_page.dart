import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/cubit/schedule_cubit.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/widgets/event.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';
import 'package:ng_poland_conf_app/widgets/empty_list_info.dart';

import '../../../widgets/confs_bottom_nav_bar.dart';
import '../../settings/presentation/connection_status.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  late final ScheduleCubit _cubit;
  final selectedTabItem = EventItemType.ngPoland;
  ConnectivityResult connectivityResult = ConnectivityResult.none;
  late StreamSubscription<ConnectivityResult> subscription;
  EventItemType _eventItemType = EventItemType.ngPoland;

  @override
  void initState() {
    _cubit = getIt.get<ScheduleCubit>();

    _cubit.getListEvents(
      eventItemType: _eventItemType,
    );
    super.initState();

    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        connectivityResult = result;
      });
    });
  }

  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }

  void onEventItemTabChange(int idx) {
    if (idx == 0) {
      _eventItemType = EventItemType.ngPoland;
    } else {
      _eventItemType = EventItemType.jsPoland;
    }
    _cubit.getListEvents(
      eventItemType: _eventItemType,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text(
          'Schedule',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        actions: const [
          ConnectionStatus(),
        ],
      ),
      body: BlocBuilder<ScheduleCubit, ScheduleState>(
        bloc: _cubit,
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (error) => const EmptyListInformation(),
            loaded: (listEvents) => listEvents.isEmpty
                ? const EmptyListInformation()
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: ListView.builder(
                        itemCount: listEvents.length,
                        itemBuilder: (context, index) {
                          return ScheduleEvent(
                            listEvents[index],
                            _eventItemType,
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
