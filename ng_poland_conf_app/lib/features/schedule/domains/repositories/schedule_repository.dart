import 'package:ng_poland_conf_app/features/schedule/domains/entities/event_item.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/usecases/get_all_events_for_conference.dart';

abstract class ScheduleRepository {
  Future<List<EventItem>> getAllEvents(Params params);
}
