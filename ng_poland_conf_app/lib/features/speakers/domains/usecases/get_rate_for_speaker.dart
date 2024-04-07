import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/usecases/usecases.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/entities/rate_speaker_basic_params.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/repositories/rate_speakers_repository.dart';

@injectable
class GetRateForSpeaker implements UseCase<int?, GetRateForSpeakerParams> {
  final RateSpeakersRepository rateSpeakersRepository;

  const GetRateForSpeaker(this.rateSpeakersRepository);

  @override
  Future<int?> call(GetRateForSpeakerParams params) async {
    return await rateSpeakersRepository.getRateForSpeaker(params);
  }
}

class GetRateForSpeakerParams extends RateSpeakerBasicParams {
  GetRateForSpeakerParams({
    required super.confId,
    required super.speakerId,
  });
}
