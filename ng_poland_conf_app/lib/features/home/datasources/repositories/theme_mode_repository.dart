import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/home/datasources/data/theme_mode_local_datasource.dart';
import 'package:ng_poland_conf_app/features/home/domains/repositories/theme_mode_repository.dart';

@Singleton(as: ThemeModeRepository)
class ThemeModeImpl implements ThemeModeRepository {
  final ThemeModeLocalDataSource themeModeLocalDataSource;

  ThemeModeImpl(this.themeModeLocalDataSource);

  @override
  Future<ThemeMode> getThemeMode() async {
    ThemeMode themeMode = await themeModeLocalDataSource.getThemeMode();

    return themeMode;
  }

  @override
  Future<void> updateThemeMode(ThemeMode themeMode) async {
    await themeModeLocalDataSource.updateThemeMode(themeMode);
  }
}
