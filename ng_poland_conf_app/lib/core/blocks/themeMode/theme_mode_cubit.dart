import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/home/domains/repositories/theme_mode_repository.dart';
import 'package:ng_poland_conf_app/injectable.dart';

part 'theme_mode_state.dart';
part 'theme_mode_cubit.freezed.dart';

@singleton
class ThemeModeCubit extends Cubit<ThemeModeState> {
  ThemeModeCubit(this._themeModes) : super(const ThemeModeState.initial());

  final ThemeModeRepository _themeModes;

  Future<void> getThemeMode() async {
    final themeMode = await _themeModes.getThemeMode();
    emit(ThemeModeState.loaded(themeMode));
  }

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    await _themeModes.updateThemeMode(themeMode);
    emit(ThemeModeState.loaded(themeMode));
  }
}

bool get isDarkMode => getIt.get<ThemeModeCubit>().state.isDarkMode;
