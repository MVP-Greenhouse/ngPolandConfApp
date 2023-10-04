import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/entities/speaker.dart';

part 'event_item.freezed.dart';

@freezed
class EventItem with _$EventItem {
  const EventItem._();

  const factory EventItem({
    required String title,
    required String? confId,
    required String? type,
    required String? category,
    required String? shortDescription,
    required String? description,
    required DateTime? startDate,
    required DateTime? endDate,
    required Speaker? speaker,
  }) = _EventItem;

  String startTime() {
    final startDate = this.startDate;

    if (startDate == null) return '';

    return DateFormat('hh:mm').format(startDate);
  }

  String endTime() {
    final endDate = this.endDate;

    if (endDate == null) return '';

    return DateFormat('hh:mm').format(endDate);
  }
}
