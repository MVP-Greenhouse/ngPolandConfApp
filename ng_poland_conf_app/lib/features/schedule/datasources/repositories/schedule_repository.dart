import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/schedule/datasources/data/schedule_remote_datasource.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/entities/event_item.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/repositories/schedule_repository.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/usecases/get_all_events_for_conference.dart';

@Singleton(as: ScheduleRepository)
class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleRemoteDataSource scheduleRemoteDataSource;

  ScheduleRepositoryImpl(this.scheduleRemoteDataSource);

  @override
  Future<List<EventItem>> getAllEvents(Params params) async {
    final listAllEvents = await scheduleRemoteDataSource.getAllEvents(
      eventItemType: params.eventItemType,
      confId: params.confId,
      limit: params.limit,
    );

    return listAllEvents.toEntity();
  }
}
