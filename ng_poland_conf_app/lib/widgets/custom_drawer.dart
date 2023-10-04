import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/core/blocks/themeMode/theme_mode_cubit.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/routing/routing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final Pages currentPage = getIt.get<Routing>().currentPage(context);

    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        children: <Widget>[
          const DrawerHeader(
            child: Text(
              'Drawer Header',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          for (Pages page in Pages.values)
            _buildCustomListTile(
              context,
              page,
              currentPage,
            ),
          Divider(
            color: Theme.of(context).colorScheme.primaryContainer,
            height: 30.0,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
            ),
            child: BlocBuilder<ThemeModeCubit, ThemeModeState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox.shrink(),
                  loaded: (ThemeMode themeMode) => _buildDarkModeSwitch(
                    context,
                    themeMode: themeMode,
                  ),
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
    Pages currentPage,
  ) {
    return ListTile(
      selected: page == currentPage,
      selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
      selectedColor: Theme.of(context).colorScheme.onPrimaryContainer,
      leading: SizedBox(
        width: 34.0,
        child: Icon(
          _buildIconForPage(page),
        ),
      ),
      title: Text(
        page.nameKey,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      onTap: () => _goTo(
        context,
        page: page,
      ),
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
        const SizedBox(
          width: 16.0,
        ),
        Text(
          'DarkMode',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }

  IconData _buildIconForPage(Pages page) {
    return switch (page) {
      Pages.home => FontAwesomeIcons.gripVertical,
      Pages.schedule => FontAwesomeIcons.solidClock,
      Pages.workshops => FontAwesomeIcons.solidKeyboard,
      Pages.nggirls => FontAwesomeIcons.personDress,
      Pages.speakers => FontAwesomeIcons.users,
      Pages.info => FontAwesomeIcons.info,
      Pages.about => FontAwesomeIcons.code,
    };
  }

  ///
  /// Functions
  ///

  void _goTo(
    BuildContext context, {
    required Pages page,
  }) {
    context.go(page.path);
  }
}
