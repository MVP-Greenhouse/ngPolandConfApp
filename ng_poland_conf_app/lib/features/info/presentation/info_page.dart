import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/features/info/presentation/cubit/info_cubit.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';
import 'package:ng_poland_conf_app/widgets/empty_list_info.dart';

import '../../settings/presentation/connection_status.dart';
import 'widgets/info_details.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late final InfoCubit _infoCubit;
  ConnectivityResult connectivityResult = ConnectivityResult.none;
  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    _infoCubit = getIt.get<InfoCubit>();
    _infoCubit.getListInfoItems();
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

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
          title: Text(
            'Info',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.inversePrimary),
          ),
          actions: const [
            ConnectionStatus(),
          ]),
      body: BlocBuilder<InfoCubit, InfoState>(
        bloc: _infoCubit,
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (error) => const EmptyListInformation(),
            loaded: (listInfoItems) => listInfoItems.isEmpty
                ? const EmptyListInformation()
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: ListView.builder(
                        itemBuilder: (context, index) {
                          return InfoDetails(info: listInfoItems[index]);
                        },
                        itemCount: listInfoItems.length),
                  ),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
