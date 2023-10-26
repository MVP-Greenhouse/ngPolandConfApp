import 'package:injectable/injectable.dart';

import '../../domains/entities/speaker.dart';
import '../../domains/repositories/speakers_repository.dart';
import '../../domains/usecases/get_all_speakers_for_conference.dart';
import '../data/speakers_local_datasource.dart';
import '../data/speakers_remote_datasource.dart';
import '../models/speakers_model.dart';

@Singleton(as: SpeakersRepository)
class SpeakersRepositoryImpl implements SpeakersRepository {
  final SpeakersRemoteDataSource speakersRemoteDataSource;
  final SpeakersLocalDataSource speakersLocalDataSource;

  SpeakersRepositoryImpl(this.speakersRemoteDataSource, this.speakersLocalDataSource);

  @override
  Future<List<Speaker>> getAllSpeakers(Params params) async {
    try {
      final SpeakersModel allSpeakers = await speakersRemoteDataSource.getAllSpeakers(
        confId: params.confId,
        limit: params.limit,
      );

      await speakersLocalDataSource.update(allSpeakers);
      return allSpeakers.toEntity();
    } catch (e) {
      SpeakersModel? allSpeakersFromLocalDataSource = await speakersLocalDataSource.get();
      return allSpeakersFromLocalDataSource?.toEntity() ?? [];
    }
  }
}
