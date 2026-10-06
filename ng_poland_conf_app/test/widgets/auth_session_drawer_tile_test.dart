import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_role.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/user_session_cubit.dart';
import 'package:ng_poland_conf_app/widgets/custom_drawer.dart';

void main() {
  const profile = UserProfile(
    uid: 'u1',
    displayName: 'Ada',
    email: 'ada@example.com',
    role: UserRole.user,
  );

  testWidgets('shows Sign in when unauthenticated', (tester) async {
    var login = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AuthSessionDrawerTile(
            session: const UserSessionState.unauthenticated(),
            onLogin: () => login = true,
            onLogout: () {},
          ),
        ),
      ),
    );

    expect(find.text('Sign in'), findsOneWidget);
    expect(find.text('Sign out'), findsNothing);
    await tester.tap(find.text('Sign in'));
    expect(login, isTrue);
  });

  testWidgets('shows Sign out when authenticated', (tester) async {
    var logout = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AuthSessionDrawerTile(
            session: const UserSessionState.authenticated(profile),
            onLogin: () {},
            onLogout: () => logout = true,
          ),
        ),
      ),
    );

    expect(find.text('Sign out'), findsOneWidget);
    await tester.tap(find.text('Sign out'));
    expect(logout, isTrue);
  });

  testWidgets('hides tile while loading', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AuthSessionDrawerTile(
            session: const UserSessionState.loading(),
            onLogin: () {},
            onLogout: () {},
          ),
        ),
      ),
    );

    expect(find.text('Sign in'), findsNothing);
    expect(find.text('Sign out'), findsNothing);
  });
}
