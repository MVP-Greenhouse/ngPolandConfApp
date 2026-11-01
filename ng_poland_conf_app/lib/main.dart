import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:ng_poland_conf_app/app/app.dart';
import 'package:ng_poland_conf_app/app/di/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/hive_constants.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/magic_link_listener.dart';
import 'package:ng_poland_conf_app/features/edition/presentation/cubit/edition_cubit.dart';
import 'package:ng_poland_conf_app/features/home/presentation/cubit/conferences_cubit.dart';
import 'package:ng_poland_conf_app/features/settings/presentation/cubit/theme_mode_cubit.dart';
import 'package:ng_poland_conf_app/firebase_options.dart';
import 'package:timezone/data/latest.dart' as tzdata;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GoogleSignIn.instance.initialize();
  await Hive.initFlutter();
  await configureDependencies(Environment.prod);
  tzdata.initializeTimeZones();

  await _dropLegacyBoxes(getIt<Logger>());
  getIt<MagicLinkListener>().start();
  unawaited(getIt<EditionCubit>().load());
  unawaited(getIt<ConferencesCubit>().load());
  await getIt<ThemeModeCubit>().load();

  runApp(const App());
}

/// Deletes Hive boxes of removed features (old Contentful cache, ratings).
Future<void> _dropLegacyBoxes(Logger logger) async {
  for (final name in HiveConstantsForBoxes.legacyBoxes) {
    try {
      if (await Hive.boxExists(name)) await Hive.deleteBoxFromDisk(name);
    } on Exception catch (error, stackTrace) {
      logger.w(
        'Could not delete legacy box $name',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
