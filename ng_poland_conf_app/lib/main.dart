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
  configureDependencies(
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
              ),
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
