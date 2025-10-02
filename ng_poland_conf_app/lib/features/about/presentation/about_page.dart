import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/core/mixins/connectivity_mixin.dart';
import 'package:ng_poland_conf_app/features/about/domains/entities/author.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/blocks/themeMode/theme_mode_cubit.dart';
import '../../settings/presentation/connection_status.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  static const List<Author> _dataAuthors = [
    Author(
      name: 'Daniel Michalak',
      image: 'danielmichalak',
      linkedinUrl: 'https://www.linkedin.com/in/daniel-michalak-0219981b2/',
    ),
    Author(
      name: 'Sebastian Denis',
      image: 'sebastiandenis',
      linkedinUrl: 'https://www.linkedin.com/in/sebastian-denis-0a1782153/',
    ),
    Author(
      name: 'Dariusz Kalbarczyk',
      image: 'dariuszkalbarczyk',
      linkedinUrl: 'https://www.linkedin.com/in/ngkalbarczyk/',
    ),
  ];

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with ConnectivityMixin {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
          title: Text(
            'About',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.inversePrimary),
          ),
          actions: const [
            ConnectionStatus(),
          ]),
      body: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: BlocBuilder<ThemeModeCubit, ThemeModeState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loaded: (ThemeMode themeMode) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Image.asset('assets/images/logo.png'),
                    ),
                    Text(
                      'This app is built with Flutter!',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.primary),
                    ),
                    const Divider(
                      height: 35,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Authors:',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: themeMode == ThemeMode.light
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.primary.withAlpha(200),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Column(
                      children: AboutPage._dataAuthors
                          .map(
                            (author) => Column(
                              children: [
                                ListTile(
                                  onTap: () => launchUrl(Uri.parse(author.linkedinUrl)),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: Image.asset(
                                      'assets/images/authors/${author.image}.jpg',
                                      height: 50,
                                    ),
                                  ),
                                  title: Text(
                                    author.name,
                                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                        color: themeMode == ThemeMode.light ? const Color(0xff3F51B5) : const Color(0xff82B1FF), fontSize: 15.0),
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.02,
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                    const Divider(
                      height: 35,
                    ),
                    ListTile(
                      leading: Image.asset(
                        'assets/images/github.png',
                        height: 50,
                      ),
                      title: InkWell(
                        onTap: () => launchUrl(Uri.parse('https://github.com/MVP-Greenhouse/ngPolandConfApp')),
                        child: Text(
                          'ngPolandConfApp',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: themeMode == ThemeMode.light ? const Color(0xff3F51B5) : const Color(0xff82B1FF), fontSize: 15.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32.0),
                      child: Text(
                        'Version: 20251001.1',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimary.withAlpha(150)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
