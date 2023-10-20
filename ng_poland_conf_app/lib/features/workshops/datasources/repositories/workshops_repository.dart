import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/workshops/datasources/data/workshops_remote_datasource.dart';
import 'package:ng_poland_conf_app/features/workshops/domains/entities/workshop.dart';
import 'package:ng_poland_conf_app/features/workshops/domains/repositories/workshops_repository.dart';
import 'package:ng_poland_conf_app/features/workshops/domains/usecases/get_workshops_for_conference.dart';

@Singleton(as: WorkshopsRepository)
class WorkshopsRepositoryImpl implements WorkshopsRepository {
  final WorkshopsRemoteDataSource workshopsRemoteDataSource;

  WorkshopsRepositoryImpl(this.workshopsRemoteDataSource);

  @override
  Future<List<Workshop>> getWorkshops(Params params) async {
    final workshops = await workshopsRemoteDataSource.getWorkshops(
      eventItemType: params.eventItemType,
      confId: params.confId,
      limit: params.limit,
    );

    return workshops.toEntity();
  }
}
