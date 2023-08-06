import 'package:ng_poland_conf_app/features/workshops/domains/entities/workshop.dart';
import 'package:ng_poland_conf_app/features/workshops/domains/usecases/get_workshops_for_conference.dart';

abstract class WorkshopsRepository {
  Future<List<WorkShop>> getWorkshops(Params params);
}
