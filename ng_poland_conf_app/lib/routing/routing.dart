import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/about/presentation/about_page.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/admin_page.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/admin_shell.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/admin_voting_page.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/authentication_page.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/user_session_cubit.dart';
import 'package:ng_poland_conf_app/features/event/presentation/event_page.dart';
import 'package:ng_poland_conf_app/features/home/presentation/home_page.dart';
import 'package:ng_poland_conf_app/features/info/presentation/info_page.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/schedule_page.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/schedule_top5_page.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/speakers_page.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/widgets/speaker_details.dart';
import 'package:ng_poland_conf_app/features/workshops/presentation/workshops_page.dart';
import 'package:ng_poland_conf_app/injectable.dart';

import '../features/questions/presentation/questions_page.dart';

EventItemType? trackFromQuery(Map<String, String> queryParameters) {
  final track = queryParameters['track'];
  if (track == null || track.isEmpty) return null;
  for (final type in EventItemType.values) {
    if (type.name == track) return type;
  }
  return null;
}

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

/// Firebase Hosting / Auth email links are opened as app deep links, but they
/// are not GoRouter routes. Send the user to `/auth` while [MagicLinkDeepLinkListener]
/// completes sign-in from the same URI.
bool isFirebaseAuthDeepLink(Uri uri) {
  final path = uri.path;
  if (path.startsWith('/__/auth/')) return true;
  if (uri.queryParameters.containsKey('oobCode') &&
      (uri.queryParameters['mode']?.toLowerCase() == 'signin')) {
    return true;
  }
  final nested = uri.queryParameters['link'];
  if (nested != null && nested.isNotEmpty) {
    final nestedUri = Uri.tryParse(nested);
    if (nestedUri != null && isFirebaseAuthDeepLink(nestedUri)) return true;
  }
  return false;
}

/// Path (+ optional query) safe for in-app redirects after login.
///
/// Rejects absolute URLs, protocol-relative URLs, and `/auth` loops.
String? safeInternalRedirectPath(String? candidate) {
  if (candidate == null || candidate.isEmpty) return null;

  final value = candidate.trim();
  if (value.contains('://') ||
      value.startsWith('//') ||
      value.contains(r'\') ||
      value.contains('\n') ||
      value.contains('\r')) {
    return null;
  }
  if (!value.startsWith('/')) return null;

  final uri = Uri.tryParse(value);
  if (uri == null || uri.hasScheme || uri.host.isNotEmpty) return null;

  final path = uri.path;
  if (path.isEmpty || !path.startsWith('/')) return null;
  if (path == AuthenticationPage.path ||
      path.startsWith('${AuthenticationPage.path}/')) {
    return null;
  }

  return uri.hasQuery ? '$path?${uri.query}' : path;
}

/// Location string suitable for [AuthenticationPage.loginPath] `from`.
String internalLocationFromUri(Uri uri) {
  if (uri.hasScheme || uri.host.isNotEmpty) {
    return uri.hasQuery ? '${uri.path}?${uri.query}' : uri.path;
  }
  return uri.toString();
}

String? authRedirect({
  required String matchedLocation,
  required String? fullPath,
  required Map<String, String> queryParameters,
  required bool isAuthenticated,
  Uri? uri,
}) {
  if (uri != null && isFirebaseAuthDeepLink(uri)) {
    return AuthenticationPage.path;
  }

  // GoRouter may pass the full https://… Auth URL as matchedLocation.
  if (matchedLocation.contains('/__/auth/') ||
      (fullPath?.contains('/__/auth/') ?? false)) {
    return AuthenticationPage.path;
  }

  if (!isAuthenticated) {
    return null;
  }

  final onAuth =
      matchedLocation == AuthenticationPage.path ||
      (fullPath?.contains(AuthenticationPage.path) ?? false);
  if (!onAuth) {
    return null;
  }

  return safeInternalRedirectPath(queryParameters['from']) ?? Pages.home.path;
}

enum Pages {
  home('/', 'Home'),
  schedule('/schedule', 'Schedule'),
  workshops('/workshops', 'Workshops'),
  speakers('/speakers', 'Speakers'),
  questions('/questions', 'Q&A'),
  info('/info', 'Info'),
  about('/about', 'About');

  final String path;
  final String nameKey;

  const Pages(this.path, this.nameKey);
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
        if (isFirebaseAuthDeepLink(state.uri) ||
            state.matchedLocation.contains('/__/auth/')) {
          return AuthenticationPage.path;
        }

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
          uri: state.uri,
        );
      },
      onException: (context, state, router) {
        if (isFirebaseAuthDeepLink(state.uri) ||
            state.uri.toString().contains('/__/auth/')) {
          router.go(AuthenticationPage.path);
          return;
        }
        router.go(Pages.home.path);
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
        GoRoute(
          path: Pages.schedule.path,
          builder: (context, state) => SchedulePage(
            initialTrack: trackFromQuery(state.uri.queryParameters),
          ),
          routes: [
            GoRoute(
              path: '${ScheduleTop5Page.pathSegment}/:eventItemType',
              name:
                  '${Pages.schedule.nameKey}-${ScheduleTop5Page.routeNameKey}',
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
                return SpeakerDetails(
                  id: id!,
                  conference: state.uri.queryParameters['conference'] ?? '',
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: Pages.workshops.path,
          builder: (context, state) => WorkshopsPage(
            initialDayKey: state.uri.queryParameters['day'],
            initialWorkshopId: int.tryParse(
              state.uri.queryParameters['workshop'] ?? '',
            ),
          ),
          routes: [
            GoRoute(
              path: 'speaker/${SpeakerDetails.routeName}/:id',
              name: '${Pages.workshops.nameKey}-${SpeakerDetails.routeNameKey}',
              builder: (context, state) {
                final id = state.pathParameters['id'];
                final speakers = state.uri.queryParameters['speakers'];
                return SpeakerDetails(
                  id: id!,
                  conference: state.uri.queryParameters['conference'] ?? '',
                  workshopSpeakerIds: speakers == null
                      ? const []
                      : [
                          for (final slug in speakers.split(','))
                            if (slug.isNotEmpty) slug,
                        ],
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: Pages.speakers.path,
          builder: (context, state) => const SpeakersPage(),
          routes: [
            GoRoute(
              path: '${SpeakerDetails.routeName}/:id',
              name: '${Pages.speakers.nameKey}-${SpeakerDetails.routeNameKey}',
              builder: (context, state) {
                // Extract the id from the path
                final id = state.pathParameters['id'];
                return SpeakerDetails(
                  id: id!,
                  conference: state.uri.queryParameters['conference'] ?? '',
                );
              },
            ),
          ],
        ),
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
