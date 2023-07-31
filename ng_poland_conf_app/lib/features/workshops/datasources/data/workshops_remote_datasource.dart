import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/workshops/datasources/models/workshops_model.dart';
import 'package:retrofit/retrofit.dart';

part 'workshops_remote_datasource.g.dart';

@RestApi()
@injectable
abstract class WorkshopsRemoteDataSource {
  @factoryMethod
  factory WorkshopsRemoteDataSource(
    Dio dio,
  ) = _WorkshopsRemoteDataSource;

  @GET('&content_type=${EventContentTypes.workshop}&fields.type={eventItemType}&fields.confId={confId}&limit={limit}&order=fields.startDate')
  Future<WorkshopsModel> getWorkshops({
    @Path() required String eventItemType,
    @Path() required String confId,
    @Path() required int limit,
  });
}
