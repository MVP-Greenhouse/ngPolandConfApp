import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/info/datasources/models/info_items_model.dart';
import 'package:retrofit/retrofit.dart';

part 'info_remote_datasource.g.dart';

@RestApi()
@injectable
abstract class InfoRemoteDataSource {
  @factoryMethod
  factory InfoRemoteDataSource(
    Dio dio,
  ) = _InfoRemoteDataSource;

  @GET('&content_type=${EventContentTypes.infoItem}&fields.confId={confId}&limit={limit}&order=fields.order')
  Future<InfoItemsModel> getAllInfoItems({
    @Path() required String confId,
    @Path() required int limit,
  });
}
