import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/core/presentation/theme/app_palette.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  error: Color(0xfff44336),
  errorContainer: Color(0xffb00020),
  inversePrimary: Color(0xffffffff),
  inverseSurface: Color(0xff000000),
  onError: Color(0xffffffff),
  onErrorContainer: Color(0xffffffff),
  onInverseSurface: Color(0xffffffff),
  onPrimary: Color(0xff000000),
  onPrimaryContainer: Color(0xffffffff),
  onSecondary: Color(0xff000000),
  onSecondaryContainer: Color(0xff000000),
  onSurface: Color(0xff000000),
  onSurfaceVariant: Color(0xff000000),
  onTertiary: Color(0xff000000),
  onTertiaryContainer: Color(0xff000000),
  outline: Color(0xff000000),
  outlineVariant: Color(0xff000000),
  primary: Color(0xff673ab7),
  primaryContainer: Color(0xff6200ee),
  secondary: Color(0xffff007a),
  secondaryContainer: Color(0xffffffff),
  shadow: Color(0xff000000),
  surface: Color(0xffffffff),
  surfaceTint: Color(0xff6200ee),
  surfaceContainerHighest: Color(0xffffffff),
  tertiary: Color(0xffFF4081),
  tertiaryContainer: Color.fromARGB(255, 221, 107, 107),
);

const lightButtonColorScheme = ColorScheme(
  brightness: Brightness.light,
  error: Color(0xfff44336),
  errorContainer: Color(0xffb00020),
  inversePrimary: Color(0xffffffff),
  inverseSurface: Color(0xff000000),
  onError: Color(0xffffffff),
  onErrorContainer: Color(0xffffffff),
  onInverseSurface: Color(0xffffffff),
  onPrimary: Color(0xff000000),
  onPrimaryContainer: Color(0xffffffff),
  onSecondary: Color(0xff000000),
  onSecondaryContainer: Color(0xff000000),
  onSurface: Color(0xff000000),
  onSurfaceVariant: Color(0xff000000),
  onTertiary: Color(0xff000000),
  onTertiaryContainer: Color(0xff000000),
  outline: Color(0xff000000),
  outlineVariant: Color(0xff000000),
  primary: Color(0xff673ab7),
  primaryContainer: Color(0xff6200ee),
  secondary: Color(0xff673ab7),
  secondaryContainer: Color(0xff03dac6),
  shadow: Color(0xff000000),
  surface: Color(0xffffffff),
  surfaceTint: Color(0xff6200ee),
  surfaceContainerHighest: Color(0xffffffff),
  tertiary: Color(0xffFF4081),
  tertiaryContainer: Color.fromARGB(255, 221, 107, 107),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  error: Color(0xffd32f2f),
  errorContainer: Color(0xffd32f2f),
  inversePrimary: Color(0xffffffff),
  inverseSurface: Color(0xffffffff),
  onError: Color(0xff000000),
  onErrorContainer: Color(0xff000000),
  onInverseSurface: Color(0xff424242),
  onPrimary: Color(0xffffffff),
  onPrimaryContainer: Color(0xffffffff),
  onSecondary: Color(0xffffffff),
  onSecondaryContainer: Color(0xff000000),
  onSurface: Color(0xffffffff),
  onSurfaceVariant: Color(0xffffffff),
  onTertiary: Color(0xff000000),
  onTertiaryContainer: Color(0xff000000),
  outline: Color(0xffffffff),
  outlineVariant: Color(0xffffffff),
  primary: Color(0xffFFEDEB),
  primaryContainer: Color(0xffE91E63),
  secondary: Color(0xffF50057),
  secondaryContainer: Color(0xff4f00d0),
  shadow: Color(0xff000000),
  surface: Color(0xff424242),
  surfaceTint: Color(0xff4A148C),
  surfaceContainerHighest: Color(0xff424242),
  tertiary: Color(0xffA9C7FF),
  tertiaryContainer: Color(0xff82B1FF),
);

const darkButtonColorScheme = ColorScheme(
  brightness: Brightness.dark,
  error: Color(0xffd32f2f),
  errorContainer: Color(0xffd32f2f),
  inversePrimary: Color(0xffffffff),
  inverseSurface: Color(0xffffffff),
  onError: Color(0xff000000),
  onErrorContainer: Color(0xff000000),
  onInverseSurface: Color(0xff424242),
  onPrimary: Color(0xffffffff),
  onPrimaryContainer: Color(0xffffffff),
  onSecondary: Color(0xffffffff),
  onSecondaryContainer: Color(0xff000000),
  onSurface: Color(0xffffffff),
  onSurfaceVariant: Color(0xffffffff),
  onTertiary: Color(0xff000000),
  onTertiaryContainer: Color(0xff000000),
  outline: Color(0xffffffff),
  outlineVariant: Color(0xffffffff),
  primary: Color(0xff4A148C),
  primaryContainer: Color(0xff4A148C),
  secondary: Color(0xffff4081),
  secondaryContainer: Color(0xff64ffda),
  shadow: Color(0xff000000),
  surface: Color(0xff424242),
  surfaceTint: Color(0xff4A148C),
  surfaceContainerHighest: Color(0xff424242),
  tertiary: Color(0xff64ffda),
  tertiaryContainer: Color(0xff64ffda),
);

final appLightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xff4f00d0),
    foregroundColor: Color(0xfffdfdfd),
    shadowColor: Color(0xfffafafb),
  ),
  applyElevationOverlayColor: false,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xff4f00d0),
    selectedItemColor: Color(0xfffdfdfd),
    unselectedItemColor: Color(0x8a9a7bff),
  ),
  buttonTheme: const ButtonThemeData(
    alignedDropdown: false,
    colorScheme: lightButtonColorScheme,
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: lightButtonColorScheme.primary,
      foregroundColor: Colors.white,
      disabledBackgroundColor: lightButtonColorScheme.primary.withValues(
        alpha: 0.38,
      ),
      disabledForegroundColor: Colors.white.withValues(alpha: 0.38),
    ),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return lightColorScheme.outline;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return lightColorScheme.secondary;
      }
      return lightColorScheme.surfaceContainerHighest;
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.transparent;
      }
      return lightColorScheme.outline;
    }),
  ),
  dividerTheme: DividerThemeData(
    color: lightColorScheme.secondary,
    thickness: 1.0,
    space: 0.0,
    indent: 0.0,
    endIndent: 0.0,
  ),
  textTheme: TextTheme(
    displayLarge: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: lightColorScheme.onSecondary,
    ),
    bodyMedium: const TextStyle(fontSize: 28, fontWeight: FontWeight.normal),
    bodySmall: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    displayMedium: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: lightColorScheme.onPrimary,
    ),
    displaySmall: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
  ),
  extensions: const [AppPalette.light],
);

final appDarkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xffE91E63),
    foregroundColor: Color(0xfffdfdfd),
    shadowColor: Color(0xFF4A3A5C),
  ),
  applyElevationOverlayColor: false,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xff4f00d0),
    selectedItemColor: Color(0xfffdfdfd),
    unselectedItemColor: Color(0x8a9a7bff),
  ),
  buttonTheme: const ButtonThemeData(
    alignedDropdown: false,
    colorScheme: darkButtonColorScheme,
  ),
  // Dark ColorScheme.primary is near-white (#FFEDEB); brand
  // purple/pink keep FilledButton and Switch readable.
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: darkButtonColorScheme.primary,
      foregroundColor: darkButtonColorScheme.onPrimary,
      disabledBackgroundColor: darkButtonColorScheme.primary.withValues(
        alpha: 0.38,
      ),
      disabledForegroundColor: darkButtonColorScheme.onPrimary.withValues(
        alpha: 0.38,
      ),
    ),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return darkColorScheme.outline;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return darkColorScheme.primaryContainer;
      }
      return darkColorScheme.surfaceContainerHighest;
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.transparent;
      }
      return darkColorScheme.outline;
    }),
  ),
  dividerTheme: DividerThemeData(
    color: darkColorScheme.primary,
    thickness: 1.0,
    space: 0.0,
    indent: 0.0,
    endIndent: 0.0,
  ),
  textTheme: TextTheme(
    displayLarge: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: darkColorScheme.onSecondary,
    ),
    bodyMedium: const TextStyle(fontSize: 28, fontWeight: FontWeight.normal),
    bodySmall: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    displayMedium: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: darkColorScheme.onPrimary,
    ),
    displaySmall: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
  ),
  extensions: const [AppPalette.dark],
);
