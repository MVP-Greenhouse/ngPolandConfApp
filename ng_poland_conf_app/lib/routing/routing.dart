import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/presentation/about/about_page.dart';
import 'package:ng_poland_conf_app/presentation/home/home_page.dart';
import 'package:ng_poland_conf_app/presentation/info/info_page.dart';
import 'package:ng_poland_conf_app/presentation/nggirls/nggirls_page.dart';
import 'package:ng_poland_conf_app/presentation/schedule/schedule_page.dart';
import 'package:ng_poland_conf_app/presentation/speakers/speakers_page.dart';
import 'package:ng_poland_conf_app/presentation/workshops/workshops_page.dart';

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

final router = GoRouter(
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
);
