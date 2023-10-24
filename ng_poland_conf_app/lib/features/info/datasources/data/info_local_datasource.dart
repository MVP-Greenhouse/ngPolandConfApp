import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../domains/entities/info_item.dart';

abstract class InfoLocalDataSource {
  Future<List<InfoItem>> getAllInfoItems();
  Future<void> saveInfoItems(List<InfoItem> infoItems);
}

@Singleton(as: InfoLocalDataSource)
class InfoLocalDataSourceImpl implements InfoLocalDataSource {
  static const String _nameBox = 'infoitems';
  static const String _nameKey = 'allitems';

  @override
  Future<List<InfoItem>> getAllInfoItems() async {
    Box box = await _getBox();
    List<dynamic> dynamicList = box.get(_nameKey);
    List<InfoItem> items = dynamicList.cast<InfoItem>();
    return items;
  }

  @override
  Future<void> saveInfoItems(List<InfoItem> infoItems) async {
    Box box = await _getBox();
    await box.put(_nameKey, infoItems);
  }

  Future<Box> _getBox() async {
    final boxExists = await Hive.boxExists(_nameBox);
    final isOpen = Hive.isBoxOpen(_nameBox);

    if (!boxExists || !isOpen) await Hive.openBox(_nameBox);

    final Box box = Hive.box(_nameBox);

    if (box.get(_nameKey) == null) box.put(_nameKey, []);

    return box;
  }
}
