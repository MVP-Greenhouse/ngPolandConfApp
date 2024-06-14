import 'package:hive/hive.dart';

class HiveService {
  const HiveService._();

  static Future<bool> save<T>(String nameBox, String key, T value) async {
    try {
      final Box<T> box = await _getBox(nameBox);
      await box.put(key, value);
      return true;
    } catch (err) {
      return false;
    }
  }

  static Future<T?> get<T>(String nameBox, String key) async {
    try {
      final Box<T> box = await _getBox(nameBox);
      T? value = box.get(key);
      return value;
    } catch (err) {
      return null;
    }
  }

  static Future<bool> clear<T>(String nameBox) async {
    try {
      final Box<T> box = await _getBox<T>(nameBox);
      await box.clear();
      return true;
    } catch (err) {
      return false;
    }
  }

  static Future<Box<T>> _getBox<T>(String nameBox) async {
    final boxExists = await Hive.boxExists(nameBox);
    final isOpen = Hive.isBoxOpen(nameBox);

    if (!boxExists || !isOpen) await Hive.openBox<T>(nameBox);

    final Box<T> box = Hive.box(nameBox);
    return box;
  }
}

abstract interface class HiveLocalDataSource<T> {
  Future<T?> get({String? customKey});

  Future<bool> update(T data, {String? customKey});

  Future<bool> clear();
}
