import 'package:app_links/app_links.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import 'app_config.dart';
import 'raw_config.dart';

@module
abstract class RegisterModule {
  @singleton
  Dio dio(AppConfig config) => Dio()..options.baseUrl = config.baseUrl;

  @lazySingleton
  AppLinks appLinks() => AppLinks();

  @lazySingleton
  FirebaseAuth firebaseAuth() => FirebaseAuth.instance;

  @lazySingleton
  Logger logger() => Logger();

  @singleton
  @preResolve
  Future<RawConfig> config() async {
    await dotenv.load(fileName: "env");

    return RawConfig.from(dotenv.env);
  }
}
