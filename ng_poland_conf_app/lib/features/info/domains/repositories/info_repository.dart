import 'package:ng_poland_conf_app/features/info/domains/entities/info_item.dart';
import 'package:ng_poland_conf_app/features/info/domains/usecases/get_all_info_items_for_conference.dart';

abstract class InfoRepository {
  Future<List<InfoItem>> getAllInfoItems(Params params);
}
