import 'package:ng_poland_conf_app/features/home/domains/entities/conferences.dart';

abstract class ConferencesRepository {
  Future<Conferences?> getAllConferences();
}
