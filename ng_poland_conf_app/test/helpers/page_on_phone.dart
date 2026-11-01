import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/core/presentation/cubit/connectivity_cubit.dart';
import 'package:ng_poland_conf_app/core/presentation/theme/app_palette.dart';

const screenHeight = 640.0;
const navigationBarHeight = 48.0;

class _FakeConnectivityCubit extends Cubit<bool?> implements ConnectivityCubit {
  _FakeConnectivityCubit() : super(true);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Pumps [page] on a screen with a 3-button navigation bar. It's wide because
/// the test font is much wider than the app's.
Future<void> pumpPageOnPhone(WidgetTester tester, Widget page) async {
  tester.view
    ..physicalSize = const Size(800, screenHeight)
    ..devicePixelRatio = 1
    ..padding = const FakeViewPadding(bottom: navigationBarHeight)
    ..viewPadding = const FakeViewPadding(bottom: navigationBarHeight);
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    BlocProvider<ConnectivityCubit>(
      create: (_) => _FakeConnectivityCubit(),
      child: MaterialApp(
        theme: ThemeData(extensions: const [AppPalette.dark]),
        home: page,
      ),
    ),
  );
  await tester.pumpAndSettle();
}

/// Empty space below the last item of the page's [ListView].
double listBottomPadding(WidgetTester tester) => tester
    .widget<ListView>(find.byType(ListView))
    .padding!
    .resolve(TextDirection.ltr)
    .bottom;
