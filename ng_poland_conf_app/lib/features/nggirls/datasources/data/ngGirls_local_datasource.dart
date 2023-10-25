// ignore: file_names
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/nggirls/domains/entities/ngGirls.dart';

abstract class NgGirlsLocalDataSource {
  Future<NgGirls> getNgGirls();
  Future<void> saveNgGirls(NgGirls ngGirls);
}

@Singleton(as: NgGirlsLocalDataSource)
class NgGirlsLocalDataSourceImpl implements NgGirlsLocalDataSource {
  static const String _nameBox = 'nggirls';
  static const String _nameKey = 'nggirlsitems';

  @override
  Future<NgGirls> getNgGirls() async {
    Box box = await _getBox();
    NgGirls ngGirls = box.get(_nameKey);
    return ngGirls;
  }

  @override
  Future<void> saveNgGirls(NgGirls ngGirls) async {
    Box box = await _getBox();
    await box.put(_nameKey, ngGirls);
  }

  Future<Box> _getBox() async {
    final boxExists = await Hive.boxExists(_nameBox);
    final isOpen = Hive.isBoxOpen(_nameBox);

    if (!boxExists || !isOpen) await Hive.openBox(_nameBox);

    final Box box = Hive.box(_nameBox);

    if (box.get(_nameKey) == null) box.put(_nameKey, NgGirls.empty());

    return box;
  }
}
