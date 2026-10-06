import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/logic/conference_datetime.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/entities/speaker.dart';

part 'event_item.freezed.dart';

@freezed
abstract class EventItem with _$EventItem {
  const EventItem._();

  const factory EventItem({
    required String id,
    required String title,
    required String confId,
    required String type,
    required String category,
    required String? shortDescription,
    required String? description,
    required DateTime? startDate,
    required DateTime? endDate,
    required Speaker? speaker,
  }) = _EventItem;

  String startTime() => ConferenceDateTime.formatHm(startDate);

  String endTime() => ConferenceDateTime.formatHm(endDate);
}
