import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/hive_constants.dart';
import 'package:ng_poland_conf_app/core/services/hive_service.dart';
import 'package:ng_poland_conf_app/features/speakers/datasources/models/speakers_model.dart';

abstract class SpeakersLocalDataSource implements HiveLocalDataSource<SpeakersModel?> {}

@Singleton(as: SpeakersLocalDataSource)
class SpeakersLocalDataSourceImpl extends SpeakersLocalDataSource {
  static const String _nameBox = HiveConstantsForBoxes.speakers;
  static const String _nameKey = HiveConstantsForBoxes.defaultKey;

  @override
  Future<SpeakersModel?> get({
    String? customKey,
  }) async {
    SpeakersModel? speakers = await HiveService.get<SpeakersModel>(_nameBox, customKey ?? _nameKey);

    return speakers;
  }

  @override
  Future<bool> update(
    SpeakersModel? speakers, {
    String? customKey,
  }) async {
    if (speakers == null) return false;

    await HiveService.save<SpeakersModel>(
      _nameBox,
      customKey ?? _nameKey,
      speakers,
    );
    return true;
  }

  @override
  Future<bool> clear() async {
    await HiveService.clear<SpeakersModel>(_nameBox);
    return true;
  }
}
