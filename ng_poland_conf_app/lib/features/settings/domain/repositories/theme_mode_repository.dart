import 'package:ng_poland_conf_app/features/settings/domain/entities/app_theme_mode.dart';

abstract interface class ThemeModeRepository {
  Future<AppThemeMode> getThemeMode();

  Future<void> setThemeMode(AppThemeMode themeMode);
}
