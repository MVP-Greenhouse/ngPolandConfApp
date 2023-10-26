import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/home/datasources/data/conferences_local_datasource.dart';
import 'package:ng_poland_conf_app/features/home/datasources/data/conferences_remote_datasource.dart';
import 'package:ng_poland_conf_app/features/home/datasources/models/conferences_model.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conferences.dart';
import 'package:ng_poland_conf_app/features/home/domains/repositories/conferences_repository.dart';

@Singleton(as: ConferencesRepository)
class ConferencesRepositoryImpl implements ConferencesRepository {
  final ConferencesRemoteDataSource conferencesRemoteDataSource;
  final ConferencesLocalDataSource conferencesLocalDataSource;

  ConferencesRepositoryImpl(
    this.conferencesRemoteDataSource,
    this.conferencesLocalDataSource,
  );

  @override
  Future<Conferences?> getAllConferences() async {
    try {
      final conferencesModel = await conferencesRemoteDataSource.getAllConferences();

      await conferencesLocalDataSource.update(conferencesModel);
      return conferencesModel?.toEntity();
    } catch (err) {
      ConferencesModel? conferencesModelFromLocalDataSource = await conferencesLocalDataSource.get();
      return conferencesModelFromLocalDataSource?.toEntity();
    }
  }
}
