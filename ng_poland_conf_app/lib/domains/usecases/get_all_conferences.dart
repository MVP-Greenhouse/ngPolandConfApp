import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/usecases/usecases.dart';
import 'package:ng_poland_conf_app/datasources/models/conferences.dart';
import 'package:ng_poland_conf_app/domains/repositories/conferences_repository.dart';

@injectable
class GetAllConference implements UseCase<List<Conferences>, NoParams> {
  final ConferencesRepository conferencesRepository;

  GetAllConference(this.conferencesRepository);

  @override
  Future<List<Conferences>> call(NoParams params) async {
    return await conferencesRepository.getAllConferences();
  }
}
