import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/widgets/magic_link_form.dart';

void main() {
  testWidgets('shows validation error for empty email', (tester) async {
    String? submitted;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MagicLinkForm(
            isLoading: false,
            onSubmit: (email) => submitted = email,
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(const ValueKey('magic_link_submit_button')));
    await tester.pump();

    expect(find.text('Enter a valid email address.'), findsOneWidget);
    expect(submitted, isNull);
  });

  testWidgets('submits trimmed email', (tester) async {
    String? submitted;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MagicLinkForm(
            isLoading: false,
            onSubmit: (email) => submitted = email,
          ),
        ),
      ),
    );

    await tester.enterText(
      find.byKey(const ValueKey('magic_link_email_field')),
      ' ada@example.com ',
    );
    await tester.tap(find.byKey(const ValueKey('magic_link_submit_button')));
    await tester.pump();

    expect(submitted, 'ada@example.com');
  });

  testWidgets('shows link sent message', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MagicLinkForm(
            isLoading: false,
            linkSent: true,
            initialEmail: 'ada@example.com',
            onSubmit: _noop,
          ),
        ),
      ),
    );

    expect(find.text('Check your inbox'), findsOneWidget);
    expect(find.textContaining('ada@example.com'), findsOneWidget);
    expect(find.text('Resend'), findsOneWidget);
  });
}

void _noop(String _) {}
