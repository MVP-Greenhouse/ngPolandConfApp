import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/domain/usecases/watch_connectivity.dart';

/// Whether the device is online; `null` until the first check completes.
@singleton
class ConnectivityCubit extends Cubit<bool?> {
  ConnectivityCubit(WatchConnectivity watchConnectivity) : super(null) {
    _subscription = watchConnectivity().listen(emit);
  }

  late final StreamSubscription<bool> _subscription;

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
