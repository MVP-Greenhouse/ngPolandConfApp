import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/schedule/datasources/data/schedule_local_datasource.dart';
import 'package:ng_poland_conf_app/features/schedule/datasources/data/schedule_remote_datasource.dart';
import 'package:ng_poland_conf_app/features/schedule/datasources/models/events_model.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/entities/event_item.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/repositories/schedule_repository.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/usecases/get_all_events_for_conference.dart';

@Singleton(as: ScheduleRepository)
class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleRemoteDataSource scheduleRemoteDataSource;
  final ScheduleLocalDataSource scheduleLocalDataSource;

  ScheduleRepositoryImpl(
    this.scheduleRemoteDataSource,
    this.scheduleLocalDataSource,
  );

  @override
  Future<List<EventItem>> getAllEvents(Params params) async {
    try {
      final EventsModel listAllEvents = await scheduleRemoteDataSource.getAllEvents(
        eventItemType: params.eventItemType,
        confId: params.confId,
        limit: params.limit,
      );

      await scheduleLocalDataSource.update(listAllEvents, customKey: params.eventItemType);
      return listAllEvents.toEntity();
    } catch (err) {
      EventsModel? listAllEventsFromLocalDataSource = await scheduleLocalDataSource.get(customKey: params.eventItemType);
      return listAllEventsFromLocalDataSource?.toEntity() ?? [];
    }
  }
}
