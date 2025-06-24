import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';

mixin ConnectivityMixin<T extends StatefulWidget> on State<T> {
  ConnectivityResult connectivityResult = ConnectivityResult.none;
  late StreamSubscription<List<ConnectivityResult>> subscription;

  @override
  void initState() {
    super.initState();
    subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if (result.isEmpty) return;
      setState(() {
        connectivityResult = result.last;
      });
    });
  }

  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }
}
