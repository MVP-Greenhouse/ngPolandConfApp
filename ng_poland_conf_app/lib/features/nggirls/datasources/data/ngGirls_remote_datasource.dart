import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/nggirls/datasources/models/ngGirls_model.dart';
import 'package:retrofit/retrofit.dart';

part 'ngGirls_remote_datasource.g.dart';

@RestApi()
@injectable
abstract class NgGirlsRemoteDataSource {
  @factoryMethod
  factory NgGirlsRemoteDataSource(
    Dio dio,
  ) = _NgGirlsRemoteDataSource;

  @GET(
    '&content_type=${EventContentTypes.simpleContent}&fields.myId={ngGirlsWorkshopsId}&fields.confId={confId}',
  )
  Future<NgGirlsModel> queryNgGirls({
    @Path() required String ngGirlsWorkshopsId,
    @Path() required String confId,
  });
}
