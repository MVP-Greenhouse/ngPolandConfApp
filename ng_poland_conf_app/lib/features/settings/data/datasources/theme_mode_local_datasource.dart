import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/hive_constants.dart';
import 'package:ng_poland_conf_app/core/data/hive_store.dart';
import 'package:ng_poland_conf_app/features/settings/domain/entities/app_theme_mode.dart';

abstract interface class ThemeModeLocalDataSource {
  Future<AppThemeMode?> getThemeMode();

  Future<void> saveThemeMode(AppThemeMode themeMode);
}

@Singleton(as: ThemeModeLocalDataSource)
class ThemeModeLocalDataSourceImpl implements ThemeModeLocalDataSource {
  const ThemeModeLocalDataSourceImpl(this._store);

  static const _box = HiveConstantsForBoxes.themeMode;
  static const _key = HiveConstantsForBoxes.defaultKey;
  static final _byName = AppThemeMode.values.asNameMap();

  final HiveStore _store;

  @override
  Future<AppThemeMode?> getThemeMode() async {
    final stored = await _store.get<String>(_box, _key);
    return _byName[stored?.toLowerCase()];
  }

  @override
  Future<void> saveThemeMode(AppThemeMode themeMode) =>
      _store.save<String>(_box, _key, themeMode.name);
}
