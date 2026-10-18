part of 'theme_mode_cubit.dart';

sealed class ThemeModeState {
  const ThemeModeState();

  bool get isDarkMode => switch (this) {
    ThemeModeLoaded(themeMode: ThemeMode.dark) => true,
    _ => false,
  };
}

class ThemeModeInitial extends ThemeModeState {
  const ThemeModeInitial();
}

class ThemeModeLoaded extends ThemeModeState {
  const ThemeModeLoaded(this.themeMode);

  final ThemeMode themeMode;
}
