import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/utils/converters.dart';

abstract class ThemeModeLocalDataSource {
  Future<ThemeMode> getThemeMode();

  Future<void> updateThemeMode(ThemeMode themeMode);
}

@Singleton(as: ThemeModeLocalDataSource)
class ThemeModeLocalDataSourceImpl implements ThemeModeLocalDataSource {
  static const String _nameBox = 'themeMode';
  static const String _nameKey = 'mode';

  @override
  Future<ThemeMode> getThemeMode() async {
    Box box = await _getBox();

    String themeModeInString = box.get(_nameKey);

    ThemeMode themeMode = Converters.themeModeFromString(themeModeInString);

    return themeMode;
  }

  @override
  Future<void> updateThemeMode(ThemeMode themeMode) async {
    Box box = await _getBox();

    await box.put(_nameKey, themeMode.name);
  }

  Future<Box> _getBox() async {
    final boxExists = await Hive.boxExists(_nameBox);
    final isOpen = Hive.isBoxOpen(_nameBox);

    if (!boxExists || !isOpen) await Hive.openBox(_nameBox);

    final Box box = Hive.box(_nameBox);

    if (box.get(_nameKey) == null) box.put(_nameKey, ThemeMode.system.name);

    return box;
  }
}
