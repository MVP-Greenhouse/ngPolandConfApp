import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/usecases/usecases.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/entities/rate_speaker_basic_params.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/repositories/rate_speakers_repository.dart';

@injectable
class RateSpeaker implements UseCase<int?, RateSpeakerParams> {
  final RateSpeakersRepository rateSpeakersRepository;

  const RateSpeaker(this.rateSpeakersRepository);

  @override
  Future<int?> call(RateSpeakerParams params) async {
    return await rateSpeakersRepository.rateSpeaker(params);
  }
}

class RateSpeakerParams extends RateSpeakerBasicParams {
  final int rate;

  RateSpeakerParams({
    required super.confId,
    required super.speakerId,
    required this.rate,
  });
}
