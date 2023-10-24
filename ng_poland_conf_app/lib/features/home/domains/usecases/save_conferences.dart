import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/usecases/usecases.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conferences.dart';
import 'package:ng_poland_conf_app/features/home/domains/repositories/conferences_repository.dart';

@injectable
class SaveConferences implements UseCase<void, Params> {
  final ConferencesRepository conferencesRepository;

  SaveConferences(this.conferencesRepository);

  @override
  Future<void> call(Params params) async {
    return await conferencesRepository.saveConferences(params.confs);
  }
}

class Params {
  final Conferences? confs;

  Params({required this.confs});
}
