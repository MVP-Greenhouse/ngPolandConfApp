import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/core/presentation/navigation/app_pages.dart';
import 'package:ng_poland_conf_app/core/presentation/navigation/redirect_paths.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_session.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/user_session_cubit.dart';
import 'package:ng_poland_conf_app/features/settings/presentation/cubit/theme_mode_cubit.dart';

/// Main navigation drawer shown by every top-level page.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  /// Top-level page owning [location], or `null` (e.g. for admin routes).
  static Pages? pageFor(String location) {
    if (location == Pages.home.path) return Pages.home;
    return Pages.values.firstWhereOrNull(
      (page) =>
          page != Pages.home &&
          (location == page.path || location.startsWith('${page.path}/')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final isAdminRoute = location.startsWith(AppPaths.admin);
    final currentPage = pageFor(location);
    final session = context.watch<UserSessionCubit>();
    final scheme = Theme.of(context).colorScheme;

    return Drawer(
      backgroundColor: scheme.surface.withAlpha(210),
      shadowColor: scheme.surface,
      child: ListView(
        padding: const .symmetric(horizontal: 8),
        children: [
          DrawerHeader(
            padding: const .symmetric(vertical: 8),
            child: Image.asset('assets/images/logo.png'),
          ),
          for (final page in Pages.values)
            _PageTile(page: page, selected: page == currentPage),
          AdminDrawerTile(
            visible: session.state.isAdmin,
            selected: isAdminRoute,
            onTap: () => context.go(AppPaths.admin),
          ),
          AuthSessionDrawerTile(
            session: session.state,
            onLogin: () => context.push(
              loginPath(
                from: internalLocationFromUri(GoRouterState.of(context).uri),
              ),
            ),
            onLogout: session.signOut,
          ),
          Divider(color: scheme.primary, thickness: 1, height: 30),
          const Padding(
            padding: .symmetric(horizontal: 12),
            child: Align(alignment: .centerLeft, child: _DarkModeSwitch()),
          ),
        ],
      ),
    );
  }
}

class _PageTile extends StatelessWidget {
  const _PageTile({required this.page, required this.selected});

  final Pages page;
  final bool selected;

  FaIconData get _icon => switch (page) {
    .home => FontAwesomeIcons.gripVertical,
    .schedule => FontAwesomeIcons.solidClock,
    .workshops => FontAwesomeIcons.solidKeyboard,
    .speakers => FontAwesomeIcons.microphone,
    .questions => FontAwesomeIcons.solidComments,
    .info => FontAwesomeIcons.circleInfo,
    .about => FontAwesomeIcons.code,
  };

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = selected ? scheme.onPrimaryContainer : scheme.primary;
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: .circular(6)),
      selected: selected,
      selectedTileColor: scheme.primaryContainer,
      selectedColor: scheme.onPrimaryContainer,
      leading: SizedBox(width: 34, child: FaIcon(_icon, color: color)),
      title: Text(
        page.nameKey,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: color),
      ),
      onTap: () => context.go(page.path),
    );
  }
}

class _DarkModeSwitch extends StatelessWidget {
  const _DarkModeSwitch();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ThemeModeCubit>().state;
    if (state is! ThemeModeLoaded) return const SizedBox.shrink();

    final scheme = Theme.of(context).colorScheme;
    final dark = state.isDarkMode;
    final trackColor = dark ? scheme.primaryContainer : scheme.secondary;
    return Row(
      children: [
        Switch(
          thumbColor: WidgetStatePropertyAll(
            dark ? scheme.primary : scheme.surface,
          ),
          trackColor: WidgetStatePropertyAll(trackColor),
          trackOutlineColor: WidgetStatePropertyAll(trackColor),
          value: dark,
          onChanged: (enabled) =>
              context.read<ThemeModeCubit>().setDarkMode(enabled: enabled),
        ),
        const SizedBox(width: 16),
        Text(
          dark ? 'Dark mode' : 'Light mode',
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(color: scheme.primary),
        ),
      ],
    );
  }
}

class AuthSessionDrawerTile extends StatelessWidget {
  const AuthSessionDrawerTile({
    super.key,
    required this.session,
    required this.onLogin,
    required this.onLogout,
  });

  final UserSession session;
  final VoidCallback onLogin;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) => switch (session) {
    SessionLoading() => const SizedBox.shrink(),
    SignedOut() => _DrawerActionTile(
      title: 'Sign in',
      icon: Icons.login,
      onTap: onLogin,
    ),
    SignedIn() => _DrawerActionTile(
      title: 'Sign out',
      icon: Icons.logout,
      onTap: onLogout,
    ),
  };
}

class _DrawerActionTile extends StatelessWidget {
  const _DrawerActionTile({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: .circular(6)),
      leading: SizedBox(width: 34, child: Icon(icon, color: primary)),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: primary),
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

    final scheme = Theme.of(context).colorScheme;
    final color = selected ? scheme.onPrimaryContainer : scheme.primary;
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: .circular(6)),
      selected: selected,
      selectedTileColor: scheme.primaryContainer,
      selectedColor: scheme.onPrimaryContainer,
      leading: SizedBox(
        width: 34,
        child: FaIcon(FontAwesomeIcons.userShield, color: color),
      ),
      title: Text(
        'Admin',
        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: color),
      ),
      onTap: onTap,
    );
  }
}
