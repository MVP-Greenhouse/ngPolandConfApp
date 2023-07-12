part of 'theme_mode_cubit.dart';

@freezed
class ThemeModeState with _$ThemeModeState {
  const factory ThemeModeState.initial() = _Initial;
  const factory ThemeModeState.loaded(ThemeMode themeMode) = _Loaded;
}
