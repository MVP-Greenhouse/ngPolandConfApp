import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/hive_constants.dart';
import 'package:ng_poland_conf_app/core/services/hive_service.dart';
import 'package:ng_poland_conf_app/features/workshops/datasources/models/workshops_model.dart';

abstract class WorkshopsLocalDataSource implements HiveLocalDataSource<WorkshopsModel?> {}

@Singleton(as: WorkshopsLocalDataSource)
class WorkshopsLocalDataSourceImpl extends WorkshopsLocalDataSource {
  static const String _nameBox = HiveConstantsForBoxes.workshops;
  static const String _nameKey = HiveConstantsForBoxes.defaultKey;

  @override
  Future<WorkshopsModel?> get({
    String? customKey,
  }) async {
    WorkshopsModel? workshops = await HiveService.get<WorkshopsModel>(_nameBox, customKey ?? _nameKey);

    return workshops;
  }

  @override
  Future<bool> update(
    WorkshopsModel? workshops, {
    String? customKey,
  }) async {
    if (workshops == null) return false;

    await HiveService.save<WorkshopsModel>(
      _nameBox,
      customKey ?? _nameKey,
      workshops,
    );
    return true;
  }

  @override
  Future<bool> clear() async {
    await HiveService.clear<WorkshopsModel>(_nameBox);
    return true;
  }
}
