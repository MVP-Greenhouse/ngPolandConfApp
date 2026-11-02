import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/core/presentation/theme/app_palette.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_session.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/widgets/delete_account_button.dart';

import '../../../../helpers/fakes.dart';

Widget _app(Widget button) => MaterialApp(
  theme: ThemeData(extensions: const [AppPalette.dark]),
  home: Scaffold(body: button),
);

void main() {
  testWidgets('is hidden when signed out', (tester) async {
    await tester.pumpWidget(
      _app(
        DeleteAccountButton(
          session: const UserSession.signedOut(),
          onDelete: () async => null,
          onDeleted: () {},
        ),
      ),
    );

    expect(find.text('Delete account'), findsNothing);
  });

  testWidgets('deletes the account once confirmed', (tester) async {
    var deleteCalls = 0;
    var deleted = false;
    await tester.pumpWidget(
      _app(
        DeleteAccountButton(
          session: const UserSession.signedIn(userProfile),
          onDelete: () async {
            deleteCalls++;
            return null;
          },
          onDeleted: () => deleted = true,
        ),
      ),
    );

    await tester.tap(find.text('Delete account'));
    await tester.pumpAndSettle();
    expect(find.text('Delete your account?'), findsOneWidget);

    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(deleteCalls, 1);
    expect(deleted, isTrue);
    expect(find.text('Delete your account?'), findsNothing);
    expect(find.text('Your account was deleted'), findsOneWidget);
  });

  testWidgets('keeps the account when cancelled', (tester) async {
    var deleteCalls = 0;
    await tester.pumpWidget(
      _app(
        DeleteAccountButton(
          session: const UserSession.signedIn(userProfile),
          onDelete: () async {
            deleteCalls++;
            return null;
          },
          onDeleted: () {},
        ),
      ),
    );

    await tester.tap(find.text('Delete account'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(deleteCalls, 0);
    expect(find.text('Delete your account?'), findsNothing);
  });

  testWidgets('shows why the account was not deleted', (tester) async {
    var deleted = false;
    await tester.pumpWidget(
      _app(
        DeleteAccountButton(
          session: const UserSession.signedIn(userProfile),
          onDelete: () async => 'Sign in again first.',
          onDeleted: () => deleted = true,
        ),
      ),
    );

    await tester.tap(find.text('Delete account'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(deleted, isFalse);
    expect(find.text('Sign in again first.'), findsOneWidget);
  });

  testWidgets('says which account to choose before Google asks', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        DeleteAccountButton(
          session: const UserSession.signedIn(userProfile),
          onDelete: () async => null,
          onDeleted: () {},
        ),
      ),
    );

    await tester.tap(find.text('Delete account'));
    await tester.pumpAndSettle();

    expect(find.textContaining('choose ${userProfile.email},'), findsOneWidget);
    expect(
      find.textContaining('Google or Apple account stays'),
      findsOneWidget,
    );
  });
}
