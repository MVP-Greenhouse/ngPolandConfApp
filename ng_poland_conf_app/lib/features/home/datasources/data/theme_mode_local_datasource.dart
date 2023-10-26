import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/hive_constants.dart';
import 'package:ng_poland_conf_app/core/services/hive_service.dart';
import 'package:ng_poland_conf_app/utils/converters.dart';

abstract class ThemeModeLocalDataSource {
  Future<ThemeMode?> getThemeMode();

  Future<void> updateThemeMode(ThemeMode themeMode);
}

@Singleton(as: ThemeModeLocalDataSource)
class ThemeModeLocalDataSourceImpl implements ThemeModeLocalDataSource {
  static const String _nameBox = HiveConstantsForBoxes.themeMode;
  static const String _nameKey = HiveConstantsForBoxes.defaultKey;

  @override
  Future<ThemeMode?> getThemeMode() async {
    String? themeModeInString = await HiveService.get<String>(_nameBox, _nameKey);

    ThemeMode? themeMode = Converters.themeModeFromString(themeModeInString);
    return themeMode;
  }

  @override
  Future<void> updateThemeMode(ThemeMode themeMode) async {
    await HiveService.save<String>(_nameBox, _nameKey, themeMode.name);
  }
}
