import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/usecases/usecases.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conferences.dart';
import 'package:ng_poland_conf_app/features/home/domains/repositories/conferences_repository.dart';

@injectable
class QueryConferences implements UseCase<Conferences?, NoParams> {
  final ConferencesRepository conferencesRepository;

  QueryConferences(this.conferencesRepository);

  @override
  Future<Conferences?> call([NoParams? params]) async {
    return await conferencesRepository.queryConferences();
  }
}
