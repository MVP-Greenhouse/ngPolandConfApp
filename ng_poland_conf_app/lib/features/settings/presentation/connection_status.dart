import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/core/mixins/connectivity_mixin.dart';

class ConnectionStatus extends StatefulWidget {
  const ConnectionStatus({super.key});

  @override
  State<ConnectionStatus> createState() => _ConnectionStatusState();
}

class _ConnectionStatusState extends State<ConnectionStatus>
    with ConnectivityMixin {
  var _known = false;

  @override
  void initState() {
    super.initState();
    Connectivity().checkConnectivity().then((results) {
      if (!mounted || results.isEmpty) return;
      setState(() {
        _known = true;
        connectivityResult = results.last;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_known || connectivityResult != ConnectivityResult.none) {
      return const SizedBox.shrink();
    }

    return const Padding(
      padding: EdgeInsets.only(right: 8),
      child: Icon(Icons.wifi_off),
    );
  }
}
