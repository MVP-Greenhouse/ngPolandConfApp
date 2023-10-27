// ignore_for_file: file_names

import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/hive_constants.dart';
import 'package:ng_poland_conf_app/core/services/hive_service.dart';
import 'package:ng_poland_conf_app/features/nggirls/datasources/models/ngGirls_model.dart';

abstract class NgGirlsLocalDataSource implements HiveLocalDataSource<NgGirlsModel?> {}

@Singleton(as: NgGirlsLocalDataSource)
class NgGirlsLocalDataSourceImpl extends NgGirlsLocalDataSource {
  static const String _nameBox = HiveConstantsForBoxes.ngGirls;
  static const String _nameKey = HiveConstantsForBoxes.defaultKey;

  @override
  Future<NgGirlsModel?> get({
    String? customKey,
  }) async {
    NgGirlsModel? ngGirls = await HiveService.get<NgGirlsModel>(_nameBox, _nameKey);

    return ngGirls;
  }

  @override
  Future<bool> update(
    NgGirlsModel? ngGirls, {
    String? customKey,
  }) async {
    if (ngGirls == null) return false;

    await HiveService.save<NgGirlsModel>(
      _nameBox,
      _nameKey,
      ngGirls,
    );
    return true;
  }

  @override
  Future<bool> clear() async {
    await HiveService.clear<NgGirlsModel>(_nameBox);
    return true;
  }
}
