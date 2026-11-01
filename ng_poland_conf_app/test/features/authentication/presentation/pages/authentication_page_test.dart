import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/pages/authentication_page.dart';
import 'package:ng_poland_conf_app/features/home/presentation/cubit/conferences_cubit.dart';

class _FakeAuthenticationCubit extends Cubit<AuthenticationState>
    implements AuthenticationCubit {
  _FakeAuthenticationCubit() : super(const AuthenticationInitial());

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeConferencesCubit extends Cubit<ConferencesState>
    implements ConferencesCubit {
  _FakeConferencesCubit() : super(const ConferencesInitial());

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  testWidgets('offers Google but not email sign-in', (tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationCubit>(
            create: (_) => _FakeAuthenticationCubit(),
          ),
          BlocProvider<ConferencesCubit>(
            create: (_) => _FakeConferencesCubit(),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: GoRouter(
            routes: [
              GoRoute(path: '/', builder: (_, _) => const AuthenticationPage()),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Continue with Google'), findsOneWidget);
    expect(find.text('or use a Magic Link'), findsNothing);
    expect(find.byType(TextField), findsNothing);
  });
}
