import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/domain/use_case.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/conference.dart';
import 'package:ng_poland_conf_app/features/home/domain/repositories/conference_repository.dart';

@injectable
class WatchCurrentConference implements NoParamsStreamUseCase<Conference> {
  const WatchCurrentConference(this._repository);

  final ConferenceRepository _repository;

  @override
  Stream<Conference> call() => _repository.watchCurrent();
}
