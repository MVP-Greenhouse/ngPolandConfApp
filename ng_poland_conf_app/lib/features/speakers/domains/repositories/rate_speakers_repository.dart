import 'package:ng_poland_conf_app/features/speakers/domains/usecases/get_rate_for_speaker.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/usecases/rate_speaker.dart';

abstract class RateSpeakersRepository {
  Future<int?> rateSpeaker(RateSpeakerParams params);

  Future<int?> getRateForSpeaker(GetRateForSpeakerParams params);
}
