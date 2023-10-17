import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/workshops/presentation/cubit/workshop_cubit.dart';
import 'package:ng_poland_conf_app/features/workshops/presentation/widgets/workshops_bottom_nav.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';

class WorkShopsPage extends StatefulWidget {
  const WorkShopsPage({super.key});

  @override
  State<WorkShopsPage> createState() => _WorkShopsPageState();
}

class _WorkShopsPageState extends State<WorkShopsPage> {
  late final WorkShopCubit _cubit;

  @override
  void initState() {
    _cubit = getIt.get<WorkShopCubit>();
    _cubit.getListWorkshop(
      eventItemType: EventItemType.ngPoland,
    );

    super.initState();
  }

  void onEventItemTabChange(int idx) {
    if (idx == 0) {
      _cubit.getListWorkshop(
        eventItemType: EventItemType.ngPoland,
      );
    } else {
      _cubit.getListWorkshop(
        eventItemType: EventItemType.jsPoland,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkShopCubit, WorkShopState>(
      bloc: _cubit,
      builder: (context, state) {
        return CustomScaffold(
          body: Column(
            children: [
              state.maybeWhen(
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                loaded: (listWorkshop) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...listWorkshop
                          .map(
                            (workshop) => Text(workshop.title),
                          )
                          .toList(),
                    ],
                  );
                },
                orElse: SizedBox.shrink,
              ),
            ],
          ),
          showBottomNavigationBar: true,
          bottomNavigationBar: WorkshopsBottomNavigationBar(onItemTapped: onEventItemTabChange),
        );
      },
    );
  }
}
