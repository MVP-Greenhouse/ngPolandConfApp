part of 'theme_mode_cubit.dart';

@freezed
class ThemeModeState with _$ThemeModeState {
  bool get isDarkMode => maybeWhen(
        loaded: (themeMode) => themeMode == ThemeMode.dark,
        orElse: () => false,
      );

  const factory ThemeModeState.initial() = _Initial;
  const factory ThemeModeState.loaded(ThemeMode themeMode) = _Loaded;

  const ThemeModeState._();
}
