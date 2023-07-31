import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/usecases/usecases.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/entities/event_item.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/repositories/schedule_repository.dart';

@injectable
class GetAllEventsForConference implements UseCase<List<EventItem>?, Params> {
  final ScheduleRepository scheduleRepository;

  GetAllEventsForConference(this.scheduleRepository);

  @override
  Future<List<EventItem>> call(Params params) {
    return scheduleRepository.getAllEvents(params);
  }
}

class Params {
  final String eventItemType;
  final String confId;
  final int limit;

  Params({
    required this.eventItemType,
    required this.confId,
    required this.limit,
  });
}
