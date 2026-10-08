import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/core/blocks/themeMode/theme_mode_cubit.dart';
import 'package:ng_poland_conf_app/core/utils/authentication_utils.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/admin_page.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/authentication_page.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/user_session_cubit.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/routing/routing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final isAdminRoute = location.startsWith(AdminPage.path);
    final Pages? currentPage = isAdminRoute
        ? null
        : getIt.get<Routing>().currentPage(context);

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface.withAlpha(210),
      shadowColor: Theme.of(context).colorScheme.surface,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Image.asset('assets/images/logo.png'),
          ),
          for (Pages page in Pages.values)
            _buildCustomListTile(context, page, currentPage),
          BlocBuilder<UserSessionCubit, UserSessionState>(
            builder: (context, state) {
              return AdminDrawerTile(
                visible: state.isAdmin,
                selected: isAdminRoute,
                onTap: () => context.go(AdminPage.path),
              );
            },
          ),
          BlocBuilder<UserSessionCubit, UserSessionState>(
            builder: (context, state) {
              return AuthSessionDrawerTile(
                session: state,
                onLogin: () {
                  final from = internalLocationFromUri(
                    GoRouterState.of(context).uri,
                  );
                  context.push(AuthenticationPage.loginPath(from: from));
                },
                onLogout: AuthenticationUtils.logout,
              );
            },
          ),
          Divider(
            color: Theme.of(context).colorScheme.primary,
            thickness: 1.0,
            height: 30.0,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: BlocBuilder<ThemeModeCubit, ThemeModeState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox.shrink(),
                  loaded: (ThemeMode themeMode) =>
                      _buildDarkModeSwitch(context, themeMode: themeMode),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// Widgets
  ///

  Widget _buildCustomListTile(
    BuildContext context,
    Pages page,
    Pages? currentPage,
  ) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      selected: page == currentPage,
      selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
      selectedColor: Theme.of(context).colorScheme.onPrimaryContainer,
      leading: SizedBox(
        width: 34.0,
        child: FaIcon(
          _buildIconForPage(page),
          color: page == currentPage
              ? Theme.of(context).colorScheme.onPrimaryContainer
              : Theme.of(context).colorScheme.primary,
        ),
      ),
      title: Text(
        page.nameKey,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: page == currentPage
              ? Theme.of(context).colorScheme.onPrimaryContainer
              : Theme.of(context).colorScheme.primary,
        ),
      ),
      onTap: () => _goTo(context, page: page),
    );
  }

  Widget _buildDarkModeSwitch(
    BuildContext context, {
    required ThemeMode themeMode,
  }) {
    bool valueForSwitch = switch (themeMode) {
      ThemeMode.dark => true,
      ThemeMode.light || ThemeMode.system => false,
    };

    return Row(
      children: [
        Switch(
          thumbColor: MaterialStatePropertyAll(
            valueForSwitch
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.surface,
          ),
          trackColor: MaterialStatePropertyAll(
            valueForSwitch
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).colorScheme.secondary,
          ),
          trackOutlineColor: MaterialStatePropertyAll(
            valueForSwitch
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).colorScheme.secondary,
          ),
          value: valueForSwitch,
          onChanged: (val) async {
            ThemeMode? newThemeMode;

            if (val) {
              newThemeMode = ThemeMode.dark;
            } else {
              newThemeMode = ThemeMode.light;
            }

            await getIt.get<ThemeModeCubit>().updateThemeMode(newThemeMode);
          },
        ),
        const SizedBox(width: 16.0),
        Text(
          (valueForSwitch ? 'Dark mode' : 'Light mode'),
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }

  FaIconData _buildIconForPage(Pages page) {
    return switch (page) {
      Pages.home => FontAwesomeIcons.gripVertical,
      Pages.schedule => FontAwesomeIcons.solidClock,
      Pages.workshops => FontAwesomeIcons.solidKeyboard,
      Pages.speakers => FontAwesomeIcons.microphone,
      Pages.questions => FontAwesomeIcons.solidComments,
      Pages.info => FontAwesomeIcons.circleInfo,
      Pages.about => FontAwesomeIcons.code,
    };
  }

  //
  /// Functions
  ///

  void _goTo(BuildContext context, {required Pages page}) {
    context.go(page.path);
  }
}

class AuthSessionDrawerTile extends StatelessWidget {
  const AuthSessionDrawerTile({
    super.key,
    required this.session,
    required this.onLogin,
    required this.onLogout,
  });

  final UserSessionState session;
  final VoidCallback onLogin;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return session.when(
      loading: () => const SizedBox.shrink(),
      unauthenticated: () => _buildTile(
        context,
        title: 'Sign in',
        icon: Icons.login,
        onTap: onLogin,
      ),
      authenticated: (_) => _buildTile(
        context,
        title: 'Sign out',
        icon: Icons.logout,
        onTap: onLogout,
      ),
    );
  }

  Widget _buildTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      leading: SizedBox(
        width: 34.0,
        child: Icon(icon, color: Theme.of(context).colorScheme.primary),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      onTap: onTap,
    );
  }
}

class AdminDrawerTile extends StatelessWidget {
  const AdminDrawerTile({
    super.key,
    required this.visible,
    required this.selected,
    required this.onTap,
  });

  final bool visible;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();

    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      selected: selected,
      selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
      selectedColor: Theme.of(context).colorScheme.onPrimaryContainer,
      leading: SizedBox(
        width: 34.0,
        child: FaIcon(
          FontAwesomeIcons.userShield,
          color: selected
              ? Theme.of(context).colorScheme.onPrimaryContainer
              : Theme.of(context).colorScheme.primary,
        ),
      ),
      title: Text(
        'Admin',
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: selected
              ? Theme.of(context).colorScheme.onPrimaryContainer
              : Theme.of(context).colorScheme.primary,
        ),
      ),
      onTap: onTap,
    );
  }
}

