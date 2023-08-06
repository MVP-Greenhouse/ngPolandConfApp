import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/speakers/datasources/data/speakers_remote_datasource.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/entities/speaker.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/repositories/speakers_repository.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/usecases/get_all_speakers_for_conference.dart';

@Singleton(as: SpeakersRepository)
class SpeakersRepositoryImpl implements SpeakersRepository {
  final SpeakersRemoteDataSource speakersRemoteDataSource;

  SpeakersRepositoryImpl(this.speakersRemoteDataSource);

  @override
  Future<List<Speaker>> getAllSpeakers(Params params) async {
    final allSpeakers = await speakersRemoteDataSource.getAllSpeakers(
      confId: params.confId,
      limit: params.limit,
    );

    return allSpeakers.toEntity();
  }
}
