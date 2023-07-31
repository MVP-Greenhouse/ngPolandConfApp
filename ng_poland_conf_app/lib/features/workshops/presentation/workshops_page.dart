import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/workshops/presentation/cubit/workshop_cubit.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkShopCubit, WorkShopState>(
      bloc: _cubit,
      builder: (context, state) {
        return CustomScaffold(
          body: Column(
            children: [
              state.maybeWhen(
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
                orElse: () => const SizedBox.shrink(),
              ),
              Text('WorkShopsPage'),
            ],
          ),
        );
      },
    );
  }
}
