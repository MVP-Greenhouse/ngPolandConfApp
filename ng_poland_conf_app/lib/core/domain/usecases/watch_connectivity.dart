import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/domain/repositories/connectivity_repository.dart';
import 'package:ng_poland_conf_app/core/domain/use_case.dart';

@injectable
class WatchConnectivity implements NoParamsStreamUseCase<bool> {
  const WatchConnectivity(this._repository);

  final ConnectivityRepository _repository;

  @override
  Stream<bool> call() => _repository.watchOnline().distinct();
}
