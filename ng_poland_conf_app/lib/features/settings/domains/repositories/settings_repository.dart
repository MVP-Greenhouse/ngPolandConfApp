import 'package:ng_poland_conf_app/features/settings/domains/entities/settings.dart';

abstract class SettingsRepository {
  Future<Settings> getSettings();
}
