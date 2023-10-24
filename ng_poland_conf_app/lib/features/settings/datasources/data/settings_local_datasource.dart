import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import '../../domains/entities/settings.dart';

abstract class SettingsLocalDataSource {
  Future<Settings> getSettings();
  Future<void> updateSettings(Settings settings);
}

@Singleton(as: SettingsLocalDataSource)
class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  static const String _nameBox = 'appsettings';
  static const String _nameKey = 'settings';

  @override
  Future<Settings> getSettings() async {
    Box box = await _getBox();
    Settings settings = box.get(_nameKey);
    return settings;
  }

  @override
  Future<void> updateSettings(Settings settings) async {
    Box box = await _getBox();
    await box.put(_nameKey, settings);
  }

  Future<Box> _getBox() async {
    final boxExists = await Hive.boxExists(_nameBox);
    final isOpen = Hive.isBoxOpen(_nameBox);

    if (!boxExists || !isOpen) await Hive.openBox(_nameBox);

    final Box box = Hive.box(_nameBox);

    if (box.get(_nameKey) == null) box.put(_nameKey, Settings.initial());

    return box;
  }
}
