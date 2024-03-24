import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/usecases/usecases.dart';
import 'package:ng_poland_conf_app/features/home/domains/usecases/get_theme_mode.dart';
import 'package:ng_poland_conf_app/features/home/domains/usecases/update_theme_mode.dart';
import 'package:ng_poland_conf_app/injectable.dart';

part 'theme_mode_state.dart';
part 'theme_mode_cubit.freezed.dart';

@singleton
class ThemeModeCubit extends Cubit<ThemeModeState> {
  ThemeModeCubit() : super(const ThemeModeState.initial());

  Future<void> getThemeMode() async {
    final ThemeMode themeMode = await getIt.get<GetThemeMode>().call(NoParams());

    emit(ThemeModeState.loaded(themeMode));
  }

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    await getIt.get<UpdateThemeMode>().call(themeMode);

    emit(ThemeModeState.loaded(themeMode));
  }
}

bool get isDarkMode => getIt.get<ThemeModeCubit>().state.isDarkMode;
