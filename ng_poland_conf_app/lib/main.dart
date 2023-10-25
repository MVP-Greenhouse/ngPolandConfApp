import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/core/blocks/themeMode/theme_mode_cubit.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conference.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conference_item.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conferences.dart';
import 'package:ng_poland_conf_app/features/info/domains/entities/info_item.dart';
import 'package:ng_poland_conf_app/features/nggirls/domains/entities/ngGirls.dart';
import 'package:ng_poland_conf_app/features/settings/domains/entities/settings.dart';
import 'package:ng_poland_conf_app/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/routing/routing.dart';
import 'package:ng_poland_conf_app/theme/theme.dart';

void main() async {
  await configureDependencies(
    Environment.prod,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(SettingsAdapter());
  Hive.registerAdapter(ConferenceItemAdapter());
  Hive.registerAdapter(ConferenceAdapter());
  Hive.registerAdapter(ConferencesAdapter());
  Hive.registerAdapter(InfoItemAdapter());
  Hive.registerAdapter(NgGirlsAdapter());

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final conferencesCubit = getIt.get<ConferencesCubit>();
    conferencesCubit.getConferences();
    conferencesCubit.queryConferences();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt.get<ConferencesCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt.get<ThemeModeCubit>()..getThemeMode(),
        ),
        BlocProvider(
          create: (context) => getIt.get<SettingsCubit>()..getAppSettings(),
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
                  dividerTheme: DividerThemeData(
                    color: lightColorScheme.secondary,
                    thickness: 1.0,
                    space: 0.0,
                    indent: 0.0,
                    endIndent: 0.0,
                  ),
                  textTheme: TextTheme(
                    displayLarge: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
                    titleLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: lightColorScheme.onSecondary),
                    bodyMedium: const TextStyle(fontSize: 28, fontWeight: FontWeight.normal),
                    bodySmall: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                    displayMedium: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: lightColorScheme.onPrimary),
                    displaySmall: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  )),
              darkTheme: ThemeData(
                  useMaterial3: true,
                  colorScheme: darkColorScheme,
                  appBarTheme: const AppBarTheme(backgroundColor: Color(0xffE91E63), foregroundColor: Color(0xfffdfdfd), shadowColor: Color(0xfffafafb)),
                  applyElevationOverlayColor: false,
                  bottomNavigationBarTheme:
                      const BottomNavigationBarThemeData(backgroundColor: Color(0xff4f00d0), selectedItemColor: Color(0xfffdfdfd), unselectedItemColor: Color(0x8a9a7bff)),
                  buttonTheme: const ButtonThemeData(
                    alignedDropdown: false,
                    colorScheme: darkButtonColorScheme,
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
                    titleLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSecondary),
                    bodyMedium: const TextStyle(fontSize: 28, fontWeight: FontWeight.normal),
                    bodySmall: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                    displayMedium: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimary),
                    displaySmall: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  )),
              themeMode: themeMode,
            ),
          );
        },
      ),
    );
  }
}
