import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/schedule/datasources/models/events_model.dart';
import 'package:retrofit/retrofit.dart';

part 'schedule_remote_datasource.g.dart';

@RestApi()
@injectable
abstract class ScheduleRemoteDataSource {
  @factoryMethod
  factory ScheduleRemoteDataSource(
    Dio dio,
  ) = _ScheduleRemoteDataSource;

  @GET('&content_type=${EventContentTypes.eventItem}&fields.type={eventItemType}&fields.confId={confId}&limit={limit}&order=fields.startDate')
  Future<EventsModel> getAllEvents({
    @Path() required String eventItemType,
    @Path() required String confId,
    @Path() required int limit,
  });
}
