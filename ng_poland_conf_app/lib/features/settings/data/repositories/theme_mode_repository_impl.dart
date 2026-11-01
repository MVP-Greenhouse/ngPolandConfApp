import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/settings/data/datasources/theme_mode_local_datasource.dart';
import 'package:ng_poland_conf_app/features/settings/domain/entities/app_theme_mode.dart';
import 'package:ng_poland_conf_app/features/settings/domain/repositories/theme_mode_repository.dart';

@Singleton(as: ThemeModeRepository)
class ThemeModeRepositoryImpl implements ThemeModeRepository {
  const ThemeModeRepositoryImpl(this._localDataSource);

  static const defaultThemeMode = AppThemeMode.dark;

  final ThemeModeLocalDataSource _localDataSource;

  @override
  Future<AppThemeMode> getThemeMode() async {
    if (await _localDataSource.getThemeMode() case final stored?) return stored;
    await _localDataSource.saveThemeMode(defaultThemeMode);
    return defaultThemeMode;
  }

  @override
  Future<void> setThemeMode(AppThemeMode themeMode) =>
      _localDataSource.saveThemeMode(themeMode);
}
