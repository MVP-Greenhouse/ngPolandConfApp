import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/core/blocks/themeMode/theme_mode_cubit.dart';
import 'package:ng_poland_conf_app/features/home/datasources/models/conference_home_page_schedule_item_model.dart';
import 'package:ng_poland_conf_app/features/home/datasources/models/conference_model.dart';
import 'package:ng_poland_conf_app/features/home/datasources/models/conferences_model.dart';
import 'package:ng_poland_conf_app/features/info/datasources/models/info_item_model.dart';
import 'package:ng_poland_conf_app/features/info/datasources/models/info_items_model.dart';
import 'package:ng_poland_conf_app/features/nggirls/datasources/models/ngGirls_model.dart';
import 'package:ng_poland_conf_app/features/schedule/datasources/models/event_item_model.dart';
import 'package:ng_poland_conf_app/features/schedule/datasources/models/events_model.dart';
import 'package:ng_poland_conf_app/features/speakers/datasources/models/speaker_model.dart';
import 'package:ng_poland_conf_app/features/workshops/datasources/models/workshop_model.dart';
import 'package:ng_poland_conf_app/features/workshops/datasources/models/workshops_model.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/routing/routing.dart';
import 'package:ng_poland_conf_app/theme/theme.dart';

import 'features/speakers/datasources/models/speakers_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await configureDependencies(
    Environment.prod,
  );
  await Hive.initFlutter();

  Hive
    ..registerAdapter(ConferencesModelAdapter()) // typeId: 0
    ..registerAdapter(ConferenceModelAdapter()) // typeId: 1
    ..registerAdapter(ConferenceHomePageScheduleItemModelAdapter()) // typeId: 2
    ..registerAdapter(InfoItemsModelAdapter()) // typeId: 3
    ..registerAdapter(InfoItemModelAdapter()) // typeId: 4
    ..registerAdapter(NgGirlsModelAdapter()) // typeId: 5
    ..registerAdapter(EventsModelAdapter()) // typeId: 6
    ..registerAdapter(EventItemModelAdapter()) // typeId: 7
    ..registerAdapter(SpeakerModelAdapter()) // typeId: 8
    ..registerAdapter(WorkshopModelAdapter()) // typeId: 9
    ..registerAdapter(WorkshopsModelAdapter()) // typeId: 10
    ..registerAdapter(SpeakersModelAdapter()); // typeId: 11

  FirebaseAuth.instance.authStateChanges().listen((_) => getIt.get<Routing>().router.refresh());

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final conferencesCubit = getIt.get<ConferencesCubit>();
    conferencesCubit.getConferences();
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
              debugShowCheckedModeBanner: false,
            ),
          );
        },
      ),
    );
  }
}
