import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/cubit/schedule_cubit.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  late final ScheduleCubit _cubit;

  @override
  void initState() {
    _cubit = getIt.get<ScheduleCubit>();

    _cubit.getListEvents(
      eventItemType: EventItemType.ngPoland,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: BlocBuilder<ScheduleCubit, ScheduleState>(
        bloc: _cubit,
        builder: (context, state) {
          return state.maybeWhen(
            loaded: (listEvents) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...listEvents
                    .map(
                      (eventItem) => ListTile(
                        title: Text(
                          eventItem.title.toString(),
                        ),
                        leading: Column(
                          children: [
                            Text(eventItem.startTime()),
                            Text(eventItem.endTime()),
                          ],
                        ),
                      ),
                    )
                    .toList()
              ],
            ),
            orElse: SizedBox.shrink,
          );
        },
      ),
    );
  }
}
