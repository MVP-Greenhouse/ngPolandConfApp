import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/entities/event_item.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/entities/speaker.dart';

part 'event_item_model.freezed.dart';
part 'event_item_model.g.dart';

@freezed
class EventItemModel with _$EventItemModel {
  const EventItemModel._();

  const factory EventItemModel({
    required String? title,
    required String? confId,
    required String? type,
    required String? category,
    required String? shortDescription,
    required String? description,
    required String? startDate,
    required String? endDate,
    required Speaker? speaker,
  }) = _EventItemModel;

  factory EventItemModel.fromJson(Map<String, dynamic> json) => _$EventItemModelFromJson(json['fields']);

  EventItem toEntity() => EventItem(
        title: title ?? '',
        confId: confId,
        type: type,
        category: category,
        shortDescription: shortDescription,
        description: description,
        startDate: DateTime.tryParse(startDate ?? ''),
        endDate: DateTime.tryParse(endDate ?? ''),
        speaker: speaker,
      );
}
