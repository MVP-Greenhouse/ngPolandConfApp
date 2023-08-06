import 'package:ng_poland_conf_app/features/speakers/domains/entities/speaker.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/usecases/get_all_speakers_for_conference.dart';

abstract class SpeakersRepository {
  Future<List<Speaker>> getAllSpeakers(Params params);
}
