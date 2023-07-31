import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/config/raw_config.dart';

@singleton
class AppConfig {
  final RawConfig _config;

  AppConfig(this._config);

  String get _apiUrl => _config['api_url']!;
  String get _accessToken => _config['access_token']!;
  String get _spaceId => _config['space_id']!;

  String get baseUrl => '${_apiUrl}spaces/$_spaceId/environments/master/entries?access_token=$_accessToken';
}
