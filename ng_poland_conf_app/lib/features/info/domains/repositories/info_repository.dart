import 'package:ng_poland_conf_app/features/info/domains/entities/info_item.dart';
import '../usecases/query_info_items.dart';

abstract class InfoRepository {
  Future<List<InfoItem>> getAllInfoItems();
  Future<List<InfoItem>> quryInfoItems(Params params);
  Future<void> saveInfoItems(List<InfoItem> items);
}
