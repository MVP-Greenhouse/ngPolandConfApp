import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/datasources/data/conferences_remote_datasource.dart';
import 'package:ng_poland_conf_app/datasources/models/conferences.dart';
import 'package:ng_poland_conf_app/domains/repositories/conferences_repository.dart';

@Singleton(as: ConferencesRepository)
class ConferencesRepositoryImpl implements ConferencesRepository {
  final ConferencesRemoteDataSource conferencesRemoteDataSource;

  ConferencesRepositoryImpl(this.conferencesRemoteDataSource);

  @override
  Future<List<Conferences>> getAllConferences() {
    return conferencesRemoteDataSource.getAllConferences();
  }

  @override
  Future<Conferences> getNewestConference() {
    return conferencesRemoteDataSource.getNewestConference();
  }
}
