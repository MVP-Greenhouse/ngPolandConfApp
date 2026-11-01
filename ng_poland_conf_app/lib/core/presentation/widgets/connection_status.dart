import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/core/presentation/cubit/connectivity_cubit.dart';

/// App bar indicator shown only while the device is offline.
class ConnectionStatus extends StatelessWidget {
  const ConnectionStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final online = context.watch<ConnectivityCubit>().state;
    if (online != false) return const SizedBox.shrink();

    return const Padding(padding: .only(right: 8), child: Icon(Icons.wifi_off));
  }
}
