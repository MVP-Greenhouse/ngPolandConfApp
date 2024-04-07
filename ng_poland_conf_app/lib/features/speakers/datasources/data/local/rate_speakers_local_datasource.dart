import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/hive_constants.dart';
import 'package:ng_poland_conf_app/core/services/hive_service.dart';

abstract class RateSpeakersLocalDataSource implements HiveLocalDataSource<int?> {}

@Singleton(as: RateSpeakersLocalDataSource)
class RateSpeakersLocalDataSourceImpl extends RateSpeakersLocalDataSource {
  static const String _nameBox = HiveConstantsForBoxes.rateSpeaker;

  @override
  Future<int?> get({
    String? customKey,
  }) async {
    if (customKey == null) return null;
    int? rateForSpeaker = await HiveService.get<int>(_nameBox, customKey);

    return rateForSpeaker;
  }

  @override
  Future<bool> update(
    int? rateForSpeaker, {
    String? customKey,
  }) async {
    if (customKey == null || rateForSpeaker == null) return false;

    await HiveService.save<int>(
      _nameBox,
      customKey,
      rateForSpeaker,
    );
    return true;
  }

  @override
  Future<bool> clear() async {
    await HiveService.clear<int>(_nameBox);
    return true;
  }
}
