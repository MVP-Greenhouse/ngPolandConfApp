import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/config/raw_config.dart';

@singleton
class AppConfig {
  static const version = '20261010.1';

  final RawConfig _config;

  AppConfig(this._config);

  String get baseUrl {
    final configured = _config['api_url'];
    if (configured == null ||
        configured.isEmpty ||
        configured.contains('contentful')) {
      return 'https://ng-poland.pl';
    }
    final trimmed = configured.endsWith('/')
        ? configured.substring(0, configured.length - 1)
        : configured;
    return trimmed;
  }
}
