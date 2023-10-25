import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/hive_constants.dart';
import 'package:ng_poland_conf_app/core/services/hive_service.dart';
import 'package:ng_poland_conf_app/features/schedule/datasources/models/events_model.dart';

abstract class ScheduleLocalDataSource implements HiveLocalDataSource<EventsModel?> {}

@Singleton(as: ScheduleLocalDataSource)
class ScheduleLocalDataSourceImpl extends ScheduleLocalDataSource {
  static const String _nameBox = HiveConstantsForBoxes.eventItem;
  static const String _nameKey = HiveConstantsForBoxes.defaultKey;

  @override
  Future<EventsModel?> get({
    String? customKey,
  }) async {
    EventsModel? eventItem = await HiveService.get<EventsModel>(_nameBox, customKey ?? _nameKey);

    return eventItem;
  }

  @override
  Future<bool> update(
    EventsModel? eventItem, {
    String? customKey,
  }) async {
    if (eventItem == null) return false;

    await HiveService.save<EventsModel>(
      _nameBox,
      customKey ?? _nameKey,
      eventItem,
    );
    return true;
  }

  @override
  Future<bool> clear() async {
    await HiveService.clear<EventsModel>(_nameBox);
    return true;
  }
}
