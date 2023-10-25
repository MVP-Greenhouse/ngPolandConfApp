import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class Converters {
  Converters._();

  static ThemeMode? themeModeFromString(String? value) {
    return ThemeMode.values.firstWhereOrNull((e) => e.name.toLowerCase() == value.toString().toLowerCase());
  }
}
