import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/about/presentation/about_page.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/admin_page.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/admin_shell.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/admin_voting_page.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/authentication_page.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/user_session_cubit.dart';
import 'package:ng_poland_conf_app/features/event/presentation/event_page.dart';
import 'package:ng_poland_conf_app/features/home/presentation/home_page.dart';
import 'package:ng_poland_conf_app/features/info/presentation/info_page.dart';
import 'package:ng_poland_conf_app/features/nggirls/presentation/nggirls_page.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/schedule_page.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/schedule_top5_page.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/speakers_page.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/widgets/speaker_details.dart';
import 'package:ng_poland_conf_app/features/workshops/presentation/workshops_page.dart';
import 'package:ng_poland_conf_app/injectable.dart';

import '../features/questions/presentation/questions_page.dart';

String? adminGuardRedirect({
  required String matchedLocation,
  required UserSessionState session,
}) {
  if (!matchedLocation.startsWith(AdminPage.path)) return null;
  final isLoading = session.maybeWhen(loading: () => true, orElse: () => false);
  if (isLoading) return null;
  if (!session.isAdmin) return Pages.home.path;
  return null;
}

String? authRedirect({
  required String matchedLocation,
  required String? fullPath,
  required Map<String, String> queryParameters,
  required bool isAuthenticated,
}) {
  if (!isAuthenticated) {
    return null;
  }

  final onAuth = matchedLocation == AuthenticationPage.path ||
      (fullPath?.contains(AuthenticationPage.path) ?? false);
  if (!onAuth) {
    return null;
  }

  final from = queryParameters['from'];
  if (from != null && from.isNotEmpty) {
    return from;
  }
  return Pages.home.path;
}

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
        if (state.matchedLocation.startsWith(AdminPage.path)) {
          return adminGuardRedirect(
            matchedLocation: state.matchedLocation,
            session: getIt.get<UserSessionCubit>().state,
          );
        }

        final session = getIt.get<UserSessionCubit>().state;
        final isAuthenticated = session.maybeWhen(
          authenticated: (_) => true,
          orElse: () => false,
        );
        return authRedirect(
          matchedLocation: state.matchedLocation,
          fullPath: state.fullPath,
          queryParameters: state.uri.queryParameters,
          isAuthenticated: isAuthenticated,
        );
      },
      routes: [
        GoRoute(
          path: AuthenticationPage.path,
          builder: (context, state) => const AuthenticationPage(),
        ),
        ShellRoute(
          builder: (context, state, child) => AdminShell(child: child),
          routes: [
            GoRoute(
              path: AdminPage.path,
              builder: (context, state) => const AdminPage(),
              routes: [
                GoRoute(
                  path: 'voting',
                  builder: (context, state) => const AdminVotingPage(),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: Pages.home.path,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(path: Pages.schedule.path, builder: (context, state) => const SchedulePage(), routes: [
          GoRoute(
            path: '${ScheduleTop5Page.pathSegment}/:eventItemType',
            name: '${Pages.schedule.nameKey}-${ScheduleTop5Page.routeNameKey}',
            builder: (context, state) {
              final eventItemType = state.pathParameters['eventItemType'];
              return ScheduleTop5Page(eventItemType: eventItemType!);
            },
          ),
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
