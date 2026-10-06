import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:ng_poland_conf_app/core/constants/hive_constants.dart';
import 'package:ng_poland_conf_app/core/services/hive_service.dart';
import 'package:ng_poland_conf_app/features/authentication/datasources/data/magic_link_email_local_datasource.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MagicLinkEmailLocalDataSourceImpl dataSource;

  setUp(() async {
    final dir = await Directory.systemTemp.createTemp('magic_link_hive_');
    Hive.init(dir.path);
    dataSource = MagicLinkEmailLocalDataSourceImpl();
  });

  tearDown(() async {
    await Hive.deleteFromDisk();
  });

  test('saves and reads pending email', () async {
    await dataSource.savePendingEmail('ada@example.com');

    expect(await dataSource.getPendingEmail(), 'ada@example.com');
    expect(HiveConstantsForBoxes.magicLinkPendingEmail, isNotEmpty);
  });

  test('clears pending email', () async {
    await dataSource.savePendingEmail('ada@example.com');
    await dataSource.clearPendingEmail();

    expect(await dataSource.getPendingEmail(), isNull);
  });

  test('expires pending email after TTL', () async {
    await dataSource.savePendingEmail('ada@example.com');
    await HiveService.save<String>(
      HiveConstantsForBoxes.magicLinkPendingEmail,
      'savedAt',
      DateTime.now().toUtc().subtract(const Duration(hours: 2)).toIso8601String(),
    );

    expect(await dataSource.getPendingEmail(), isNull);
  });
}
