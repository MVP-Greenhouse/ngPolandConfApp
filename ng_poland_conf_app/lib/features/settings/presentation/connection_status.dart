import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/core/mixins/connectivity_mixin.dart';

class ConnectionStatus extends StatefulWidget {
  const ConnectionStatus({Key? key}) : super(key: key);

  @override
  State<ConnectionStatus> createState() => _ConnectionStatusState();
}

class _ConnectionStatusState extends State<ConnectionStatus> with ConnectivityMixin {
  bool hasConnection = false;

  @override
  void initState() {
    super.initState();
    (Connectivity().checkConnectivity()).then((status) {
      setState(() {
        hasConnection = status != ConnectivityResult.none;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return hasConnection
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.wifi_off,
              color: Theme.of(context).colorScheme.onError,
            ),
          );
  }
}
