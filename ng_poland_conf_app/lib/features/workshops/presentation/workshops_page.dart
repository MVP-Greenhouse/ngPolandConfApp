import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/workshops/presentation/cubit/workshop_cubit.dart';
import 'package:ng_poland_conf_app/features/workshops/presentation/widgets/workshops_content.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';

import '../../../widgets/confs_bottom_nav_bar.dart';

class WorkshopsPage extends StatefulWidget {
  const WorkshopsPage({super.key});

  @override
  State<WorkshopsPage> createState() => _WorkshopsPageState();
}

class _WorkshopsPageState extends State<WorkshopsPage> {
  late final WorkshopCubit _cubit;

  @override
  void initState() {
    _cubit = getIt.get<WorkshopCubit>();
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
    return CustomScaffold(
      body: BlocBuilder<WorkshopCubit, WorkshopState>(
        bloc: _cubit,
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (listWorkshop) => ListView.builder(
              itemCount: listWorkshop.length,
              itemBuilder: (context, index) {
                return WorkshopsContent(workshop: listWorkshop[index]);
              },
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
