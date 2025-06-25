import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/about/presentation/about_page.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/authentication_page.dart';
import 'package:ng_poland_conf_app/features/event/presentation/event_page.dart';
import 'package:ng_poland_conf_app/features/home/presentation/home_page.dart';
import 'package:ng_poland_conf_app/features/info/presentation/info_page.dart';
import 'package:ng_poland_conf_app/features/nggirls/presentation/nggirls_page.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/schedule_page.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/speakers_page.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/widgets/speaker_details.dart';
import 'package:ng_poland_conf_app/features/workshops/presentation/workshops_page.dart';

import '../features/questions/presentation/questions_page.dart';

enum Pages {
  home('/', 'Home'),
  schedule('/schedule', 'Schedule'),
  workshops('/workshops', 'Workshops'),
  nggirls('/nggirls', 'ngGirls'),
  speakers('/speakers', 'Speakers'),
  questions('/questions', 'Q&A'),
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

  Pages currentPage(BuildContext context) => Pages.values.firstWhere(
        (page) => page.path == ModalRoute.of(context)?.settings.name,
        orElse: () => Pages.home,
      );

  Routing() {
    navigatorKey = GlobalKey<NavigatorState>();
    router = GoRouter(
      redirect: (_, state) {
        bool authentication = FirebaseAuth.instance.currentUser == null;
        if (authentication) {
          return AuthenticationPage.path;
        } else {
          if (state.fullPath?.contains(AuthenticationPage.path) ?? true) {
            return Pages.home.path;
          }
          return state.path;
        }
      },
      routes: [
        GoRoute(
          path: AuthenticationPage.path,
          builder: (context, state) => const AuthenticationPage(),
        ),
        GoRoute(
          path: Pages.home.path,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(path: Pages.schedule.path, builder: (context, state) => const SchedulePage(), routes: [
          GoRoute(
            path: 'schedule/${EventPage.routeName}/:eventId/:eventItemType',
            name: '${Pages.schedule.nameKey}-${EventPage.routeNameKey}',
            builder: (context, state) {
              final eventId = state.pathParameters['eventId'];
              final eventItemType = state.pathParameters['eventItemType'];
              return EventPage(
                eventId: eventId!,
                eventItemType: eventItemType!,
              );
            },
          ),
          GoRoute(
            path: 'speaker/${SpeakerDetails.routeName}/:id',
            name: '${Pages.schedule.nameKey}-${SpeakerDetails.routeNameKey}',
            builder: (context, state) {
              // Extract the id from the path
              final id = state.pathParameters['id'];
              return SpeakerDetails(id: id!);
            },
          )
        ]),
        GoRoute(path: Pages.workshops.path, builder: (context, state) => const WorkshopsPage(), routes: [
          GoRoute(
            path: 'speaker/${SpeakerDetails.routeName}/:id',
            name: '${Pages.workshops.nameKey}-${SpeakerDetails.routeNameKey}',
            builder: (context, state) {
              // Extract the id from the path
              final id = state.pathParameters['id'];
              return SpeakerDetails(id: id!);
            },
          )
        ]),
        GoRoute(
          path: Pages.nggirls.path,
          builder: (context, state) => const NgGirlsPage(),
        ),
        GoRoute(path: Pages.speakers.path, builder: (context, state) => const SpeakersPage(), routes: [
          GoRoute(
            path: '${SpeakerDetails.routeName}/:id',
            name: '${Pages.speakers.nameKey}-${SpeakerDetails.routeNameKey}',
            builder: (context, state) {
              // Extract the id from the path
              final id = state.pathParameters['id'];
              return SpeakerDetails(id: id!);
            },
          )
        ]),
        GoRoute(
          path: Pages.questions.path,
          builder: (context, state) => const QuestionsPage(),
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
