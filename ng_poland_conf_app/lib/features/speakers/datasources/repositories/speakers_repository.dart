import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/speakers/datasources/data/local/speakers_local_datasource.dart';
import 'package:ng_poland_conf_app/features/speakers/datasources/data/remote/speakers_remote_datasource.dart';

import '../../domains/entities/speaker.dart';
import '../../domains/repositories/speakers_repository.dart';
import '../../domains/usecases/get_all_speakers_for_conference.dart';
import '../models/speakers_model.dart';

@Singleton(as: SpeakersRepository)
class SpeakersRepositoryImpl implements SpeakersRepository {
  final SpeakersRemoteDataSource speakersRemoteDataSource;
  final SpeakersLocalDataSource speakersLocalDataSource;

  SpeakersRepositoryImpl(this.speakersRemoteDataSource, this.speakersLocalDataSource);

  @override
  Future<List<Speaker>> getAllSpeakers(Params params) async {
    final currentSpeakersModel = await speakersLocalDataSource.get();
    try {
      if (currentSpeakersModel != null &&
          currentSpeakersModel.items != null &&
          currentSpeakersModel.items!.isNotEmpty &&
          currentSpeakersModel.lastUpdate != null &&
          currentSpeakersModel.confId != null &&
          currentSpeakersModel.confId == params.confId &&
          currentSpeakersModel.lastUpdate!.isAfter(DateTime.now().subtract(const Duration(minutes: 5)))) {
        return currentSpeakersModel.toEntity();
      }
      final SpeakersModel allSpeakers = await speakersRemoteDataSource.getAllSpeakers(
        confId: params.confId,
        limit: params.limit,
      );

      await speakersLocalDataSource.update(allSpeakers.copyWith(confId: params.confId, lastUpdate: DateTime.now()));
      return allSpeakers.toEntity();
    } catch (e) {
      if (currentSpeakersModel != null && currentSpeakersModel.confId == params.confId) {
        return currentSpeakersModel.toEntity();
      } else {
        return [];
      }
    }
  }
}
