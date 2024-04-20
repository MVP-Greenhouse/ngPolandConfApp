import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/hive_constants.dart';
import 'package:ng_poland_conf_app/core/services/hive_service.dart';

abstract class RateEventLocalDataSource implements HiveLocalDataSource<int?> {}

@Singleton(as: RateEventLocalDataSource)
class RateEventLocalDataSourceImpl extends RateEventLocalDataSource {
  static const String _nameBox = HiveConstantsForBoxes.rateEvent;

  @override
  Future<int?> get({
    String? customKey,
  }) async {
    if (customKey == null) return null;
    int? rateEvent = await HiveService.get<int>(_nameBox, customKey);

    return rateEvent;
  }

  @override
  Future<bool> update(
    int? rateEvent, {
    String? customKey,
  }) async {
    if (customKey == null || rateEvent == null) return false;

    await HiveService.save<int>(
      _nameBox,
      customKey,
      rateEvent,
    );
    return true;
  }

  @override
  Future<bool> clear() async {
    await HiveService.clear<int>(_nameBox);
    return true;
  }
}
