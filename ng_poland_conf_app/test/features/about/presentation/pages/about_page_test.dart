import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/about/presentation/pages/about_page.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../helpers/page_on_phone.dart';

void main() {
  setUpAll(
    () => PackageInfo.setMockInitialValues(
      appName: 'NG Poland',
      packageName: 'com.mvpgreenhouse.ng_poland_conf_app',
      version: '1.4.0',
      buildNumber: '16',
      buildSignature: '',
    ),
  );

  Future<void> scrollToEnd(WidgetTester tester) async {
    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -3000),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('shows the installed app version', (tester) async {
    await pumpPageOnPhone(tester, const AboutPage());
    await scrollToEnd(tester);

    expect(find.text('Version: 1.4.0 (16)'), findsOneWidget);
  });

  testWidgets('the last line can scroll clear of the navigation bar', (
    tester,
  ) async {
    await pumpPageOnPhone(tester, const AboutPage());
    await scrollToEnd(tester);

    expect(
      tester.getRect(find.textContaining('Version: ')).bottom,
      lessThanOrEqualTo(screenHeight - navigationBarHeight),
    );
  });
}
