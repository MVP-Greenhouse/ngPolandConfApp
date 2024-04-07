import 'package:injectable/injectable.dart';

abstract class RateSpeakersRemoteDataSource {
  const RateSpeakersRemoteDataSource();

  Future<int> rateSpeaker({
    required String confId,
    required String speakerId,
    required int rate,
  });

  Future<int> getRateForSpeaker({
    required String confId,
    required String speakerId,
  });
}

@Singleton(as: RateSpeakersRemoteDataSource)
class RateSpeakersRemoteDataSourceImpl implements RateSpeakersRemoteDataSource {
  @override
  Future<int> getRateForSpeaker({
    required String confId,
    required String speakerId,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<int> rateSpeaker({
    required String confId,
    required String speakerId,
    required int rate,
  }) async {
    return rate;
  }
}
