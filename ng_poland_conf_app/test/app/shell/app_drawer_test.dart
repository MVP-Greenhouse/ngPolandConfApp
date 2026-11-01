import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/app/shell/app_drawer.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_session.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/delete_account.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/sign_out.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/watch_user_session.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/user_session_cubit.dart';
import 'package:ng_poland_conf_app/features/settings/presentation/cubit/theme_mode_cubit.dart';

import '../../helpers/fakes.dart';

class _FakeThemeModeCubit extends Cubit<ThemeModeState>
    implements ThemeModeCubit {
  _FakeThemeModeCubit() : super(const ThemeModeInitial());

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Future<GlobalKey<ScaffoldState>> _pumpOpenDrawer(WidgetTester tester) async {
  final authentication = FakeAuthenticationRepository();
  final session = UserSessionCubit(
    WatchUserSession(
      FakeUserSessionRepository(const UserSession.signedIn(userProfile)),
    ),
    SignOut(authentication),
    DeleteAccount(authentication, FakeUserRepository()),
  );
  addTearDown(session.close);
  final scaffold = GlobalKey<ScaffoldState>();

  await tester.pumpWidget(
    MultiBlocProvider(
      providers: [
        BlocProvider<UserSessionCubit>.value(value: session),
        BlocProvider<ThemeModeCubit>(create: (_) => _FakeThemeModeCubit()),
      ],
      child: MaterialApp.router(
        routerConfig: GoRouter(
          routes: [
            GoRoute(
              path: '/',
              builder: (_, _) =>
                  Scaffold(key: scaffold, drawer: const AppDrawer()),
            ),
          ],
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  scaffold.currentState!.openDrawer();
  await tester.pumpAndSettle();
  return scaffold;
}

void main() {
  testWidgets('Delete account can scroll clear of the navigation bar', (
    tester,
  ) async {
    const screenHeight = 640.0;
    const navigationBarHeight = 48.0;
    tester.view
      ..physicalSize = const Size(360, screenHeight)
      ..devicePixelRatio = 1
      ..padding = const FakeViewPadding(bottom: navigationBarHeight)
      ..viewPadding = const FakeViewPadding(bottom: navigationBarHeight);
    addTearDown(tester.view.reset);

    await _pumpOpenDrawer(tester);

    await tester.drag(find.byType(ListView), const Offset(0, -2000));
    await tester.pumpAndSettle();

    expect(
      tester.getRect(find.widgetWithText(TextButton, 'Delete account')).bottom,
      lessThanOrEqualTo(screenHeight - navigationBarHeight),
    );
  });

  testWidgets('Back closes the open drawer instead of leaving the app', (
    tester,
  ) async {
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    final appHandlesBack = <bool>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'SystemNavigator.setFrameworkHandlesBack') {
          appHandlesBack.add(call.arguments as bool);
        }
        return null;
      },
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );

    final scaffold = await _pumpOpenDrawer(tester);

    expect(appHandlesBack.lastOrNull, isTrue);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(scaffold.currentState!.isDrawerOpen, isFalse);
    expect(appHandlesBack.last, isFalse);
  });
}
