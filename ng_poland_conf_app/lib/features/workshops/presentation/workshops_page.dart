import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/core/mixins/connectivity_mixin.dart';
import 'package:ng_poland_conf_app/features/workshops/presentation/cubit/workshop_cubit.dart';
import 'package:ng_poland_conf_app/features/workshops/presentation/widgets/workshops_content.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';
import 'package:ng_poland_conf_app/widgets/empty_list_info.dart';

import '../../../widgets/confs_bottom_nav_bar.dart';
import '../../settings/presentation/connection_status.dart';

class WorkshopsPage extends StatefulWidget {
  const WorkshopsPage({super.key});

  @override
  State<WorkshopsPage> createState() => _WorkshopsPageState();
}

class _WorkshopsPageState extends State<WorkshopsPage> with ConnectivityMixin {
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
      appBar: AppBar(
          title: Text(
            'Workshops',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.inversePrimary),
          ),
          actions: const [
            ConnectionStatus(),
          ]),
      body: BlocBuilder<WorkshopCubit, WorkshopState>(
        bloc: _cubit,
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (error) => const EmptyListInformation(),
            loaded: (listWorkshop) => listWorkshop.isEmpty
                ? const EmptyListInformation()
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ListView.builder(
                      itemCount: listWorkshop.length,
                      itemBuilder: (context, index) {
                        return WorkshopsContent(workshop: listWorkshop[index]);
                      },
                    ),
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
