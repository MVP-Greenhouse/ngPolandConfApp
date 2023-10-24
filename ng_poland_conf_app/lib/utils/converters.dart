import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import '../features/settings/domains/entities/settings.dart';

class Converters {
  Converters._();

  static ThemeMode themeModeFromString(String value) {
    return ThemeMode.values.firstWhereOrNull((e) => e.name.toLowerCase() == value.toString().toLowerCase()) ?? ThemeMode.system;
  }

  static Settings settingsFromString(String value) {
    print('=====> settingsFromString: $value <=====');
    return Settings.initial();
  }
}
