import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/domain/use_case.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/conference.dart';
import 'package:ng_poland_conf_app/features/home/domain/repositories/conference_repository.dart';

@injectable
class LoadCurrentConference implements NoParamsUseCase<Conference> {
  const LoadCurrentConference(this._repository);

  final ConferenceRepository _repository;

  @override
  Future<Conference> call() => _repository.loadCurrent();
}
