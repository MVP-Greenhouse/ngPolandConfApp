import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/usecases/usecases.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/entities/event_item.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/repositories/schedule_repository.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/usecases/get_all_events_for_conference.dart' as schedule;

@injectable
class GetEvent implements UseCase<EventItem, Params> {
  final ScheduleRepository scheduleRepository;

  GetEvent(this.scheduleRepository);

  @override
  Future<EventItem> call(Params params) async {
    final List<EventItem> events = await scheduleRepository.getAllEvents(
      schedule.Params(
        confId: params.confId,
        eventItemType: params.eventItemType,
        limit: params.limit,
      ),
    );
    return events.firstWhere(
      (event) => event.id == params.eventId,
    );
  }
}

class Params extends schedule.Params {
  final String eventId;

  Params({
    required this.eventId,
    required super.confId,
    required super.eventItemType,
    required super.limit,
  });
}
