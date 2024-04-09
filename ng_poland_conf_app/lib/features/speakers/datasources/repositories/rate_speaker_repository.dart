import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/speakers/datasources/data/local/rate_speakers_local_datasource.dart';
import 'package:ng_poland_conf_app/features/speakers/datasources/data/remote/rate_speakers_remote_datasource.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/repositories/rate_speakers_repository.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/usecases/get_rate_for_speaker.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/usecases/rate_speaker.dart';

@Singleton(as: RateSpeakersRepository)
class RateSpeakersRepositoryImpl implements RateSpeakersRepository {
  final RateSpeakersRemoteDataSource rateSpeakersRemoteDataSource;
  final RateSpeakersLocalDataSource rateSpeakersLocalDataSource;

  RateSpeakersRepositoryImpl(this.rateSpeakersRemoteDataSource, this.rateSpeakersLocalDataSource);

  @override
  Future<int?> rateSpeaker(RateSpeakerParams params) async {
    try {
      final int rateForSpeaker = await rateSpeakersRemoteDataSource.rateSpeaker(
        confId: params.confId,
        speakerId: params.speakerId,
        rate: params.rate,
      );
      await rateSpeakersLocalDataSource.update(
        rateForSpeaker,
        customKey: params.keyForLocalStorage,
      );
      return rateForSpeaker;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<int?> getRateForSpeaker(GetRateForSpeakerParams params) async {
    try {
      final int rateForSpeaker = await rateSpeakersRemoteDataSource.getRateForSpeaker(
        confId: params.confId,
        speakerId: params.speakerId,
      );
      await rateSpeakersLocalDataSource.update(
        rateForSpeaker,
        customKey: params.keyForLocalStorage,
      );
      return rateForSpeaker;
    } catch (_) {
      final int? rateForSpeaker = await rateSpeakersLocalDataSource.get(
        customKey: params.keyForLocalStorage,
      );
      return rateForSpeaker;
    }
  }
}
