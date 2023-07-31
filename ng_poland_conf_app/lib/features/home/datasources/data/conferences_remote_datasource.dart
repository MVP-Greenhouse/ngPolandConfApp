import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/home/datasources/models/conferences_model.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:retrofit/retrofit.dart';

part 'conferences_remote_datasource.g.dart';

@RestApi()
@injectable
abstract class ConferencesRemoteDataSource {
  @factoryMethod
  factory ConferencesRemoteDataSource(
    Dio dio,
  ) = _ConferencesRemoteDataSource;

  @GET('&content_type=${EventContentTypes.conferences}')
  Future<ConferencesModel?> getAllConferences();
}
