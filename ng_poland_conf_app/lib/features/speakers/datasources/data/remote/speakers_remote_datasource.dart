import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/speakers/datasources/models/speakers_model.dart';
import 'package:retrofit/retrofit.dart';

part 'speakers_remote_datasource.g.dart';

@RestApi()
@injectable
abstract class SpeakersRemoteDataSource {
  @factoryMethod
  factory SpeakersRemoteDataSource(
    Dio dio,
  ) = _SpeakersRemoteDataSource;

  @GET('&content_type=${EventContentTypes.speaker}&fields.confIds={confId}&limit={limit}&order=fields.name')
  Future<SpeakersModel> getAllSpeakers({
    @Path() required String confId,
    @Path() required int limit,
  });
}
