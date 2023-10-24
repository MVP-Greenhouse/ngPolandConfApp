import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/settings/domains/repositories/settings_repository.dart';

import '../../../domains/entities/settings.dart';
import '../settings_local_datasource.dart';

@Singleton(as: SettingsRepository)
class SettingsImpl implements SettingsRepository {
  final SettingsLocalDataSource settingsLocalDataSource;

  SettingsImpl(this.settingsLocalDataSource);

  @override
  Future<Settings> getSettings() async {
    Settings settings = await settingsLocalDataSource.getSettings();

    return settings;
  }

  // @override
  // Future<void> updateThemeMode(ThemeMode themeMode) async {
  //   await themeModeLocalDataSource.updateThemeMode(themeMode);
  // }
}
