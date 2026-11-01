import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/app/di/injectable.dart';
import 'package:ng_poland_conf_app/app/routing/redirects.dart';
import 'package:ng_poland_conf_app/core/constants/firebase_hosting.dart';
import 'package:ng_poland_conf_app/core/presentation/navigation/app_pages.dart';
import 'package:ng_poland_conf_app/core/presentation/navigation/redirect_paths.dart';
import 'package:ng_poland_conf_app/features/about/presentation/pages/about_page.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/cubit/admin_cubit.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/pages/admin_page.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/pages/admin_shell.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/pages/admin_voting_page.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_session.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/user_session_cubit.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/pages/authentication_page.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/event/presentation/cubit/event_cubit.dart';
import 'package:ng_poland_conf_app/features/event/presentation/cubit/event_vote_cubit.dart';
import 'package:ng_poland_conf_app/features/event/presentation/pages/event_page.dart';
import 'package:ng_poland_conf_app/features/home/presentation/pages/home_page.dart';
import 'package:ng_poland_conf_app/features/info/presentation/cubit/info_cubit.dart';
import 'package:ng_poland_conf_app/features/info/presentation/pages/info_page.dart';
import 'package:ng_poland_conf_app/features/questions/presentation/pages/questions_page.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/cubit/schedule_cubit.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/cubit/schedule_top5_cubit.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/cubit/schedule_voting_banner_cubit.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/pages/schedule_page.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/pages/schedule_top5_page.dart';
import 'package:ng_poland_conf_app/features/speakers/domain/usecases/get_speaker_details.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/cubit/speaker_details_cubit.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/cubit/speakers_cubit.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/pages/speaker_details_page.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/pages/speakers_page.dart';
import 'package:ng_poland_conf_app/features/workshops/presentation/cubit/workshops_cubit.dart';
import 'package:ng_poland_conf_app/features/workshops/presentation/pages/workshops_page.dart';

/// App routes. Each page gets its cubits here, so widgets never touch the
/// service locator.
@singleton
class AppRouter {
  AppRouter(this._session);

  final UserSessionCubit _session;

  late final GoRouter router = GoRouter(
    refreshListenable: _StreamListenable(_session.stream),
    redirect: (_, state) => _redirect(state, _session.state),
    onException: (context, state, router) =>
        router.go(_isAuthLink(state.uri) ? AppPaths.auth : Pages.home.path),
    routes: [
      GoRoute(
        path: AppPaths.auth,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<AuthenticationCubit>(),
          child: const AuthenticationPage(),
        ),
      ),
      ShellRoute(
        builder: (context, state, child) => BlocProvider(
          create: (_) => getIt<AdminCubit>(),
          child: AdminShell(child: child),
        ),
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
        builder: (context, state) {
          final track =
              EventItemType.fromName(state.uri.queryParameters['track']) ??
              EventItemType.ngPoland;
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => getIt<ScheduleCubit>()..selectTrack(track),
              ),
              BlocProvider(
                create: (_) =>
                    getIt<ScheduleVotingBannerCubit>()..load(track: track),
              ),
            ],
            child: const SchedulePage(),
          );
        },
        routes: [
          GoRoute(
            path: '${ScheduleTop5Page.pathSegment}/:eventItemType',
            name: '${Pages.schedule.nameKey}-${ScheduleTop5Page.routeNameKey}',
            builder: (context, state) => BlocProvider(
              create: (_) =>
                  getIt<ScheduleTop5Cubit>()..load(track: _trackParam(state)),
              child: const ScheduleTop5Page(),
            ),
          ),
          GoRoute(
            path: 'schedule/${EventPage.routeName}/:eventId/:eventItemType',
            name: '${Pages.schedule.nameKey}-${EventPage.routeNameKey}',
            builder: (context, state) {
              final eventId = state.pathParameters['eventId'] ?? '';
              final track = _trackParam(state);
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (_) =>
                        getIt<EventCubit>()
                          ..load(eventId: eventId, track: track),
                  ),
                  BlocProvider(
                    create: (_) =>
                        getIt<EventVoteCubit>(param1: eventId, param2: track),
                  ),
                ],
                child: EventPage(track: track),
              );
            },
          ),
          _speakerRoute(
            path: 'speaker/${SpeakerDetailsPage.routeName}/:id',
            name:
                '${Pages.schedule.nameKey}-${SpeakerDetailsPage.routeNameKey}',
          ),
        ],
      ),
      GoRoute(
        path: Pages.workshops.path,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<WorkshopsCubit>()..load(),
          child: WorkshopsPage(
            initialDayKey: state.uri.queryParameters['day'],
            initialWorkshopId: int.tryParse(
              state.uri.queryParameters['workshop'] ?? '',
            ),
          ),
        ),
        routes: [
          _speakerRoute(
            path: 'speaker/${SpeakerDetailsPage.routeName}/:id',
            name:
                '${Pages.workshops.nameKey}-${SpeakerDetailsPage.routeNameKey}',
          ),
        ],
      ),
      GoRoute(
        path: Pages.speakers.path,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<SpeakersCubit>()..selectTrack(.ngPoland),
          child: const SpeakersPage(),
        ),
        routes: [
          _speakerRoute(
            path: '${SpeakerDetailsPage.routeName}/:id',
            name:
                '${Pages.speakers.nameKey}-${SpeakerDetailsPage.routeNameKey}',
          ),
        ],
      ),
      GoRoute(
        path: Pages.questions.path,
        builder: (context, state) => const QuestionsPage(),
      ),
      GoRoute(
        path: Pages.info.path,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<InfoCubit>()..load(),
          child: const InfoPage(),
        ),
      ),
      GoRoute(
        path: Pages.about.path,
        builder: (context, state) => const AboutPage(),
      ),
    ],
  );

  static String? _redirect(GoRouterState state, UserSession session) {
    if (_isAuthLink(state.uri) ||
        state.matchedLocation.contains(firebaseAuthPathPrefix)) {
      return AppPaths.auth;
    }
    if (state.matchedLocation.startsWith(AppPaths.admin)) {
      return adminGuardRedirect(
        matchedLocation: state.matchedLocation,
        session: session,
      );
    }
    return authRedirect(
      matchedLocation: state.matchedLocation,
      fullPath: state.fullPath,
      queryParameters: state.uri.queryParameters,
      isAuthenticated: session is SignedIn,
      uri: state.uri,
    );
  }

  static bool _isAuthLink(Uri uri) =>
      isFirebaseAuthDeepLink(uri) ||
      uri.toString().contains(firebaseAuthPathPrefix);

  /// Track from the `:eventItemType` path segment (NG Poland when unknown).
  static EventItemType _trackParam(GoRouterState state) =>
      EventItemType.fromName(state.pathParameters['eventItemType']) ??
      EventItemType.ngPoland;

  static GoRoute _speakerRoute({required String path, required String name}) =>
      GoRoute(
        path: path,
        name: name,
        builder: (context, state) {
          final query = state.uri.queryParameters;
          return BlocProvider(
            create: (_) => getIt<SpeakerDetailsCubit>()
              ..load(
                GetSpeakerDetailsParams(
                  slug: state.pathParameters['id'] ?? '',
                  conference: query['conference'] ?? '',
                  workshopSpeakerSlugs: [
                    for (final slug in (query['speakers'] ?? '').split(','))
                      if (slug.isNotEmpty) slug,
                  ],
                ),
              ),
            child: const SpeakerDetailsPage(),
          );
        },
      );
}

/// Re-runs router redirects whenever [stream] emits.
class _StreamListenable extends ChangeNotifier {
  _StreamListenable(Stream<Object?> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<Object?> _subscription;

  @override
  void dispose() {
    unawaited(_subscription.cancel());
    super.dispose();
  }
}
