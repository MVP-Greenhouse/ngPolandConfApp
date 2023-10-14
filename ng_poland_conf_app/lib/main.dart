import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/core/blocks/themeMode/theme_mode_cubit.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/routing/routing.dart';
import 'package:ng_poland_conf_app/theme/theme.dart';

void main() async {
  await configureDependencies(
    Environment.prod,
  );
  await Hive.initFlutter();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt.get<ConferencesCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt.get<ThemeModeCubit>()..getThemeMode(),
        ),
      ],
      child: BlocBuilder<ThemeModeCubit, ThemeModeState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loaded: (themeMode) => MaterialApp.router(
              routerConfig: getIt.get<Routing>().router,
              theme: ThemeData(
                  useMaterial3: true,
                  colorScheme: lightColorScheme,
                  appBarTheme: const AppBarTheme(backgroundColor: Color(0xff4f00d0), foregroundColor: Color(0xfffdfdfd), shadowColor: Color(0xfffafafb)),
                  applyElevationOverlayColor: false,
                  bottomNavigationBarTheme:
                      const BottomNavigationBarThemeData(backgroundColor: Color(0xff4f00d0), selectedItemColor: Color(0xfffdfdfd), unselectedItemColor: Color(0x8a9a7bff)),
                  buttonTheme: const ButtonThemeData(
                    alignedDropdown: false,
                    colorScheme: lightButtonColorScheme,
                  ),
                  textTheme: TextTheme(
                    displayLarge: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
                    titleLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSecondary),
                    bodyMedium: const TextStyle(fontSize: 28, fontWeight: FontWeight.normal),
                    bodySmall: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    displayMedium: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSecondary),
                    displaySmall: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  )),
              darkTheme: ThemeData(
                useMaterial3: true,
                colorScheme: darkColorScheme,
              ),
              themeMode: themeMode,
            ),
          );
        },
      ),
    );
  }
}
