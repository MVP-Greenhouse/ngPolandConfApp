import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conference_item.dart';

part 'conference_home_page_schedule_item_model.freezed.dart';

part 'conference_home_page_schedule_item_model.g.dart';

@freezed
class ConferenceHomePageScheduleItemModel with _$ConferenceHomePageScheduleItemModel {
  const ConferenceHomePageScheduleItemModel._();

  const factory ConferenceHomePageScheduleItemModel({
    required String name,
    required String desc,
  }) = _ConferenceHomePageScheduleItemModel;

  factory ConferenceHomePageScheduleItemModel.fromJson(Map<String, Object?> json) => _$ConferenceHomePageScheduleItemModelFromJson(json);

  ConferenceItem toEntity() => ConferenceItem(
        name: name,
        desc: desc,
      );
}
