import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/workshops/datasources/data/workshops_local_datasource.dart';
import 'package:ng_poland_conf_app/features/workshops/datasources/data/workshops_remote_datasource.dart';
import 'package:ng_poland_conf_app/features/workshops/datasources/models/workshops_model.dart';
import 'package:ng_poland_conf_app/features/workshops/domains/entities/workshop.dart';
import 'package:ng_poland_conf_app/features/workshops/domains/repositories/workshops_repository.dart';
import 'package:ng_poland_conf_app/features/workshops/domains/usecases/get_workshops_for_conference.dart';

@Singleton(as: WorkshopsRepository)
class WorkshopsRepositoryImpl implements WorkshopsRepository {
  final WorkshopsRemoteDataSource workshopsRemoteDataSource;
  final WorkshopsLocalDataSource workshopsLocalDataSource;

  WorkshopsRepositoryImpl(
    this.workshopsRemoteDataSource,
    this.workshopsLocalDataSource,
  );

  @override
  Future<List<Workshop>> getWorkshops(Params params) async {
    try {
      final WorkshopsModel workshops = await workshopsRemoteDataSource.getWorkshops(
        eventItemType: params.eventItemType,
        confId: params.confId,
        limit: params.limit,
      );

      await workshopsLocalDataSource.update(workshops, customKey: params.eventItemType);
      return workshops.toEntity();
    } catch (err) {
      WorkshopsModel? workshopsFromLocalDataSource = await workshopsLocalDataSource.get(customKey: params.eventItemType);
      return workshopsFromLocalDataSource?.toEntity() ?? [];
    }
  }
}
