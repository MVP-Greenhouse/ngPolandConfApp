import 'package:ng_poland_conf_app/datasources/models/conferences.dart';

abstract class ConferencesRepository {
  Future<List<Conferences>> getAllConferences();

  Future<Conferences> getNewestConference();
}
