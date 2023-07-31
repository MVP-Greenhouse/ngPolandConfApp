import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/home/datasources/data/conferences_remote_datasource.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conferences.dart';
import 'package:ng_poland_conf_app/features/home/domains/repositories/conferences_repository.dart';

@Singleton(as: ConferencesRepository)
class ConferencesRepositoryImpl implements ConferencesRepository {
  final ConferencesRemoteDataSource conferencesRemoteDataSource;

  ConferencesRepositoryImpl(this.conferencesRemoteDataSource);

  @override
  Future<Conferences?> getAllConferences() async {
    final conferencesModel = await conferencesRemoteDataSource.getAllConferences();

    return conferencesModel?.toEntity();
  }
}
