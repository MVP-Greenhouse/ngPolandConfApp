import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ng_poland_conf_app/features/schedule/datasources/models/event_item_model.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/entities/event_item.dart';

part 'events_model.freezed.dart';
part 'events_model.g.dart';

@freezed
class EventsModel with _$EventsModel {
  const EventsModel._();

  const factory EventsModel({
    required List<EventItemModel>? items,
  }) = _EventsModel;

  factory EventsModel.fromJson(Map<String, dynamic> json) => _$EventsModelFromJson(json);

  List<EventItem> toEntity() =>
      items
          ?.map(
            (eventItem) => eventItem.toEntity(),
          )
          .toList() ??
      [];
}
