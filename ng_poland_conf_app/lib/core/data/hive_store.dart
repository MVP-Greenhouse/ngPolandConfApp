import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

/// Small key-value facade over Hive boxes used by local data sources.
///
/// Storage failures are logged and reported as `false`/`null`, because every
/// caller treats local persistence as best-effort.
@lazySingleton
class HiveStore {
  const HiveStore(this._logger);

  final Logger _logger;

  Future<bool> save<T>(String boxName, String key, T value) async {
    try {
      final box = await _box<T>(boxName);
      await box.put(key, value);
      return true;
    } catch (error, stackTrace) {
      _logger.w('Hive: save failed', error: error, stackTrace: stackTrace);
      return false;
    }
  }

  Future<T?> get<T>(String boxName, String key) async {
    try {
      final box = await _box<T>(boxName);
      return box.get(key);
    } catch (error, stackTrace) {
      _logger.w('Hive: read failed', error: error, stackTrace: stackTrace);
      return null;
    }
  }

  Future<bool> clear<T>(String boxName) async {
    try {
      final box = await _box<T>(boxName);
      await box.clear();
      return true;
    } catch (error, stackTrace) {
      _logger.w('Hive: clear failed', error: error, stackTrace: stackTrace);
      return false;
    }
  }

  Future<Box<T>> _box<T>(String boxName) => Hive.isBoxOpen(boxName)
      ? Future.value(Hive.box<T>(boxName))
      : Hive.openBox<T>(boxName);
}
