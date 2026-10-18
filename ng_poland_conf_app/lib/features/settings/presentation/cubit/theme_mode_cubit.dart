import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/settings/domain/entities/app_theme_mode.dart';
import 'package:ng_poland_conf_app/features/settings/domain/usecases/get_theme_mode.dart';
import 'package:ng_poland_conf_app/features/settings/domain/usecases/set_theme_mode.dart';

part 'theme_mode_state.dart';

@singleton
class ThemeModeCubit extends Cubit<ThemeModeState> {
  ThemeModeCubit(this._getThemeMode, this._setThemeMode)
    : super(const ThemeModeInitial());

  final GetThemeMode _getThemeMode;
  final SetThemeMode _setThemeMode;

  Future<void> load() async {
    final themeMode = await _getThemeMode();
    emit(ThemeModeLoaded(themeMode.toThemeMode()));
  }

  Future<void> setDarkMode({required bool enabled}) async {
    final themeMode = enabled ? AppThemeMode.dark : AppThemeMode.light;
    await _setThemeMode(themeMode);
    emit(ThemeModeLoaded(themeMode.toThemeMode()));
  }
}

extension on AppThemeMode {
  ThemeMode toThemeMode() => switch (this) {
    .light => ThemeMode.light,
    .dark => ThemeMode.dark,
    .system => ThemeMode.system,
  };
}
