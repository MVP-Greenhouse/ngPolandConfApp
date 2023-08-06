import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ng_poland_conf_app/features/home/datasources/models/conference_home_page_schedule_item_model.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conference.dart';

part 'conference_model.freezed.dart';

part 'conference_model.g.dart';

@freezed
class ConferenceModel with _$ConferenceModel {
  const ConferenceModel._();

  const factory ConferenceModel({
    required String confId,
    required String confName,
    required String description,
    String? conferencesStartDate,
    @JsonKey(
      name: 'conferenceHomePageSchedule',
      fromJson: _listItemsFromJson,
    )
        List<ConferenceHomePageScheduleItemModel>? listItems,
  }) = _ConferenceModel;

  factory ConferenceModel.fromJson(Map<String, dynamic> json) => _$ConferenceModelFromJson(json['fields']);

  Conference toEntity() {
    final listItems = this.listItems;

    return Conference(
      confId: confId,
      confName: confName,
      description: description,
      conferencesStartDate: conferencesStartDate,
      listItems: listItems != null
          ? listItems
              .map(
                (conferenceHomePageScheduleItemModel) => conferenceHomePageScheduleItemModel.toEntity(),
              )
              .toList()
          : [],
    );
  }
}

List<ConferenceHomePageScheduleItemModel> _listItemsFromJson(Map<String, dynamic>? json) {
  var items = json?['items']
      .whereType<Map<String, dynamic>>()
      .map<ConferenceHomePageScheduleItemModel>(
        (Map<String, dynamic> itemInJson) => ConferenceHomePageScheduleItemModel.fromJson(itemInJson),
      )
      .toList();

  if (items == null && items is! List<ConferenceHomePageScheduleItemModel>) return [];

  return items;
}
