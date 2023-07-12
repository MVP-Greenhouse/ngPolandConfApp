import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ng_poland_conf_app/datasources/models/conference_home_page_schedule_item.dart';

part 'conferences.freezed.dart';

part 'conferences.g.dart';

@freezed
class Conferences with _$Conferences {
  const factory Conferences({
    required String confId,
    required String confName,
    required String description,
    String? conferencesStartDate,
    @JsonKey(
      name: 'conferenceHomePageSchedule',
      fromJson: _listItemsFromJson,
    )
        List<ConferenceHomePageScheduleItem>? listItems,
  }) = _Conferences;

  factory Conferences.fromJson(Map<String, dynamic> json) => _$ConferencesFromJson(json);
}

List<ConferenceHomePageScheduleItem> _listItemsFromJson(Map<String, dynamic>? json) {
  var items = json?['items']
      .whereType<Map<String, dynamic>>()
      .map<ConferenceHomePageScheduleItem>(
        (Map<String, dynamic> itemInJson) => ConferenceHomePageScheduleItem.fromJson(itemInJson),
      )
      .toList();

  if (items == null && items is! List<ConferenceHomePageScheduleItem>) return [];

  return items;
}
