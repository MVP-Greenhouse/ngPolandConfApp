import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/about/presentation/about_page.dart';
import 'package:ng_poland_conf_app/features/home/presentation/home_page.dart';
import 'package:ng_poland_conf_app/features/info/presentation/info_page.dart';
import 'package:ng_poland_conf_app/features/nggirls/presentation/nggirls_page.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/schedule_page.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/speakers_page.dart';
import 'package:ng_poland_conf_app/features/workshops/presentation/workshops_page.dart';

enum Pages {
  home('/', 'home'),
  schedule('/schedule', 'schedule'),
  workshops('/workshops', 'workshops'),
  nggirls('/nggirls', 'nggirls'),
  speakers('/speakers', 'speakers'),
  info('/info', 'info'),
  about('/about', 'about');

  final String path;
  final String nameKey;

  const Pages(
    this.path,
    this.nameKey,
  );
}

@singleton
class Routing {
  late final GlobalKey<NavigatorState> navigatorKey;
  late final GoRouter router;

  Pages currentPage(BuildContext context) => Pages.values.firstWhere((page) => page.path == ModalRoute.of(context)?.settings.name);

  Routing() {
    navigatorKey = GlobalKey<NavigatorState>();
    router = GoRouter(
      routes: [
        GoRoute(
          path: Pages.home.path,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: Pages.schedule.path,
          builder: (context, state) => const SchedulePage(),
        ),
        GoRoute(
          path: Pages.workshops.path,
          builder: (context, state) => const WorkShopsPage(),
        ),
        GoRoute(
          path: Pages.nggirls.path,
          builder: (context, state) => const NgGirlsPage(),
        ),
        GoRoute(
          path: Pages.speakers.path,
          builder: (context, state) => const SpeakersPage(),
        ),
        GoRoute(
          path: Pages.info.path,
          builder: (context, state) => const InfoPage(),
        ),
        GoRoute(
          path: Pages.about.path,
          builder: (context, state) => const AboutPage(),
        ),
      ],
      navigatorKey: navigatorKey,
    );
  }
}
