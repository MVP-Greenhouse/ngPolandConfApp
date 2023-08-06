import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/usecases/usecases.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/entities/speaker.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/repositories/speakers_repository.dart';

@injectable
class GetAllSpeakersForConference implements UseCase<List<Speaker>?, Params> {
  final SpeakersRepository speakersRepository;

  GetAllSpeakersForConference(this.speakersRepository);

  @override
  Future<List<Speaker>> call(Params params) {
    return speakersRepository.getAllSpeakers(params);
  }
}

class Params {
  final String confId;
  final int limit;

  Params({
    required this.confId,
    required this.limit,
  });
}
