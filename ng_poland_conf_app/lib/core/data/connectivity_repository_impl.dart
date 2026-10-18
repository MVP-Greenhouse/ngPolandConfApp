import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/domain/repositories/connectivity_repository.dart';

@LazySingleton(as: ConnectivityRepository)
class ConnectivityRepositoryImpl implements ConnectivityRepository {
  const ConnectivityRepositoryImpl(this._connectivity);

  final Connectivity _connectivity;

  @override
  Stream<bool> watchOnline() async* {
    final initial = await _connectivity.checkConnectivity();
    if (initial.isNotEmpty) yield _isOnline(initial);
    yield* _connectivity.onConnectivityChanged
        .where((results) => results.isNotEmpty)
        .map(_isOnline);
  }

  static bool _isOnline(List<ConnectivityResult> results) =>
      results.last != ConnectivityResult.none;
}
