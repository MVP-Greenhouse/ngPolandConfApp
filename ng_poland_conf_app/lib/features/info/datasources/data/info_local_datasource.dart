import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/hive_constants.dart';
import 'package:ng_poland_conf_app/core/services/hive_service.dart';
import 'package:ng_poland_conf_app/features/info/datasources/models/info_items_model.dart';

abstract class InfoLocalDataSource implements HiveLocalDataSource<InfoItemsModel?> {}

@Singleton(as: InfoLocalDataSource)
class InfoLocalDataSourceImpl extends InfoLocalDataSource {
  static const String _nameBox = HiveConstantsForBoxes.infoItems;
  static const String _nameKey = HiveConstantsForBoxes.defaultKey;

  @override
  Future<InfoItemsModel?> get({
    String? customKey,
  }) async {
    InfoItemsModel? infoItems = await HiveService.get<InfoItemsModel>(_nameBox, _nameKey);

    return infoItems;
  }

  @override
  Future<bool> update(
    InfoItemsModel? infoItems, {
    String? customKey,
  }) async {
    if (infoItems == null) return false;

    await HiveService.save<InfoItemsModel>(
      _nameBox,
      _nameKey,
      infoItems,
    );
    return true;
  }

  @override
  Future<bool> clear() async {
    await HiveService.clear<InfoItemsModel>(_nameBox);
    return true;
  }
}
