import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/features/info/presentation/cubit/info_cubit.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late final InfoCubit _infoCubit;

  @override
  void initState() {
    _infoCubit = getIt.get<InfoCubit>();
    _infoCubit.getListInfoItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: BlocBuilder<InfoCubit, InfoState>(
        bloc: _infoCubit,
        builder: (context, state) {
          return state.maybeWhen(
            loaded: (listInfoItems) => Column(
              children: [
                ...listInfoItems
                    .map(
                      (infoItem) => Text(infoItem.title),
                    )
                    .toList(),
              ],
            ),
            orElse: () => SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
