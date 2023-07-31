import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

import 'app_config.dart';
import 'raw_config.dart';

@module
abstract class RegisterModule {
  @singleton
  Dio dio(AppConfig config) => Dio()..options.baseUrl = config.baseUrl;

  @singleton
  @preResolve
  Future<RawConfig> config() async {
    await dotenv.load();

    return RawConfig.from(dotenv.env);
  }
}
