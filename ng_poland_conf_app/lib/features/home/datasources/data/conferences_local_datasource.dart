import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conferences.dart';

abstract class ConferencesLocalDataSource {
  Future<Conferences> getAllConferences();
  Future<void> saveConferences(Conferences? confs);
}

@Singleton(as: ConferencesLocalDataSource)
class ConferencesLocalDataSourceImpl implements ConferencesLocalDataSource {
  static const String _nameBox = 'conferences';
  static const String _nameKey = 'allconfs';
  @override
  Future<Conferences> getAllConferences() async {
    Box box = await _getBox();
    Conferences conferences = box.get(_nameKey);
    return conferences;
  }

  @override
  Future<void> saveConferences(Conferences? confs) async {
    print('saving conferences!!!');
    Box box = await _getBox();
    await box.put(_nameKey, confs);
  }

  Future<Box> _getBox() async {
    final boxExists = await Hive.boxExists(_nameBox);
    final isOpen = Hive.isBoxOpen(_nameBox);

    if (!boxExists || !isOpen) await Hive.openBox(_nameBox);

    final Box box = Hive.box(_nameBox);

    if (box.get(_nameKey) == null) box.put(_nameKey, Conferences.initial());

    return box;
  }
}
