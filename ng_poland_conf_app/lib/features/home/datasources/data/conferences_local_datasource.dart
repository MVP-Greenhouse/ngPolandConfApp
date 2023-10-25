import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/hive_constants.dart';
import 'package:ng_poland_conf_app/core/services/hive_service.dart';
import 'package:ng_poland_conf_app/features/home/datasources/models/conferences_model.dart';

abstract class ConferencesLocalDataSource implements HiveLocalDataSource<ConferencesModel?> {}

@Singleton(as: ConferencesLocalDataSource)
class ConferencesLocalDataSourceImpl extends ConferencesLocalDataSource {
  static const String _nameBox = HiveConstantsForBoxes.conferences;
  static const String _nameKey = HiveConstantsForBoxes.defaultKey;

  @override
  Future<ConferencesModel?> get({
    String? customKey,
  }) async {
    ConferencesModel? conferences = await HiveService.get<ConferencesModel>(_nameBox, _nameKey);

    return conferences;
  }

  @override
  Future<bool> update(
    ConferencesModel? conferences, {
    String? customKey,
  }) async {
    if (conferences == null) return false;

    await HiveService.save<ConferencesModel>(
      _nameBox,
      _nameKey,
      conferences,
    );
    return true;
  }

  @override
  Future<bool> clear() async {
    await HiveService.clear<ConferencesModel>(_nameBox);
    return true;
  }
}
