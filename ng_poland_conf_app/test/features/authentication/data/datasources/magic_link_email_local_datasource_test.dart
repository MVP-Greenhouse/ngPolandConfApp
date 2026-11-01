import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:ng_poland_conf_app/core/constants/hive_constants.dart';
import 'package:ng_poland_conf_app/core/data/hive_store.dart';
import 'package:ng_poland_conf_app/features/authentication/data/datasources/magic_link_email_local_datasource.dart';

import '../../../../helpers/fakes.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late HiveStore store;
  late MagicLinkEmailLocalDataSourceImpl dataSource;

  setUp(() async {
    final dir = await Directory.systemTemp.createTemp('magic_link_hive_');
    Hive.init(dir.path);
    store = HiveStore(silentLogger);
    dataSource = MagicLinkEmailLocalDataSourceImpl(store);
  });

  tearDown(() async {
    await Hive.deleteFromDisk();
  });

  test('saves and reads pending email', () async {
    await dataSource.savePendingEmail('ada@example.com');

    expect(await dataSource.getPendingEmail(), 'ada@example.com');
  });

  test('clears pending email', () async {
    await dataSource.savePendingEmail('ada@example.com');
    await dataSource.clearPendingEmail();

    expect(await dataSource.getPendingEmail(), isNull);
  });

  test('expires pending email after TTL', () async {
    await dataSource.savePendingEmail('ada@example.com');
    await store.save<String>(
      HiveConstantsForBoxes.magicLinkPendingEmail,
      'savedAt',
      DateTime.now()
          .toUtc()
          .subtract(const Duration(hours: 2))
          .toIso8601String(),
    );

    expect(await dataSource.getPendingEmail(), isNull);
  });
}
