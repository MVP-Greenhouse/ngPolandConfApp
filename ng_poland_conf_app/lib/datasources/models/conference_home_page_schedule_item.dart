import 'package:freezed_annotation/freezed_annotation.dart';

part 'conference_home_page_schedule_item.freezed.dart';

part 'conference_home_page_schedule_item.g.dart';

@freezed
class ConferenceHomePageScheduleItem with _$ConferenceHomePageScheduleItem {
  const factory ConferenceHomePageScheduleItem({
    required String name,
    required String desc,
  }) = _ConferenceHomePageScheduleItem;

  factory ConferenceHomePageScheduleItem.fromJson(Map<String, Object?> json) => _$ConferenceHomePageScheduleItemFromJson(json);
}
