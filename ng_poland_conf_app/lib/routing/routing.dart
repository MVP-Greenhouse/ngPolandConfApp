import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/about/presentation/about_page.dart';
import 'package:ng_poland_conf_app/features/home/presentation/home_page.dart';
import 'package:ng_poland_conf_app/features/info/presentation/info_page.dart';
import 'package:ng_poland_conf_app/features/nggirls/presentation/nggirls_page.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/schedule_page.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/speakers_page.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/widgets/speaker_details.dart';
import 'package:ng_poland_conf_app/features/workshops/presentation/workshops_page.dart';

enum Pages {
  home('/', 'Home'),
  schedule('/schedule', 'Schedule'),
  workshops('/workshops', 'Workshops'),
  nggirls('/nggirls', 'ngGirls'),
  speakers('/speakers', 'Speakers'),
  info('/info', 'Info'),
  about('/about', 'About');

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
          builder: (context, state) => const WorkshopsPage(),
        ),
        GoRoute(
          path: Pages.nggirls.path,
          builder: (context, state) => const NgGirlsPage(),
        ),
        GoRoute(
          path: Pages.speakers.path,
          name: Pages.speakers.nameKey,
          builder: (context, state) => const SpeakersPage(),
          routes: [
            GoRoute(
              path: ':id',
              name: SpeakerDetails.routeName,
              builder: (context, state) {
                // Extract the id from the path
                final id = state.pathParameters['id'];
                return SpeakerDetails(id: id!);
              },
            ),
          ],
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
