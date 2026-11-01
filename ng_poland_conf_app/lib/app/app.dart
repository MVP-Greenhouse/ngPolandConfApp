import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/app/di/injectable.dart';
import 'package:ng_poland_conf_app/app/routing/app_router.dart';
import 'package:ng_poland_conf_app/app/shell/app_drawer.dart';
import 'package:ng_poland_conf_app/core/presentation/cubit/connectivity_cubit.dart';
import 'package:ng_poland_conf_app/core/presentation/theme/theme.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/app_shell_scope.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/user_session_cubit.dart';
import 'package:ng_poland_conf_app/features/edition/presentation/cubit/edition_cubit.dart';
import 'package:ng_poland_conf_app/features/home/presentation/cubit/conferences_cubit.dart';
import 'package:ng_poland_conf_app/features/home/presentation/pages/first_launch_offline_page.dart';
import 'package:ng_poland_conf_app/features/settings/presentation/cubit/theme_mode_cubit.dart';

/// Root widget: app-wide cubits, theme and router.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<EditionCubit>()),
        BlocProvider.value(value: getIt<ConferencesCubit>()),
        BlocProvider.value(value: getIt<ThemeModeCubit>()),
        BlocProvider.value(value: getIt<UserSessionCubit>()),
        BlocProvider.value(value: getIt<ConnectivityCubit>()),
      ],
      child: BlocBuilder<ThemeModeCubit, ThemeModeState>(
        builder: (context, state) => switch (state) {
          ThemeModeInitial() => const SizedBox.shrink(),
          ThemeModeLoaded(:final themeMode) => MaterialApp.router(
            routerConfig: getIt<AppRouter>().router,
            theme: appLightTheme,
            darkTheme: appDarkTheme,
            themeMode: themeMode,
            builder: (context, child) => AppShellScope(
              drawerBuilder: (_) => const AppDrawer(),
              child: _EditionGate(child: child),
            ),
          ),
        },
      ),
    );
  }
}

/// Shows the offline screen until the first edition download succeeds.
class _EditionGate extends StatelessWidget {
  const _EditionGate({required this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return switch (context.watch<EditionCubit>().state) {
      EditionFailed() => const FirstLaunchOfflinePage(),
      _ => child ?? const SizedBox.shrink(),
    };
  }
}
