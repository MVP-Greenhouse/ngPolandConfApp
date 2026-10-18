import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/app/shell/app_drawer.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_role.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_session.dart';

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
            session: const UserSession.signedOut(),
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
            session: const UserSession.signedIn(profile),
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
            session: const UserSession.loading(),
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
