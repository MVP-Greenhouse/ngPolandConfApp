import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/speaker.dart';
import 'package:ng_poland_conf_app/features/edition/domain/services/conference_datetime.dart';

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
    @Default([]) List<Speaker> speakers,
    @Default(false) bool isBreak,
    @Default('') String sessionLabel,
    @Default('') String timeLabel,
    @Default('') String icon,
    @Default('') String descriptionHtml,
  }) = _EventItem;

  bool get hasSpeaker => speakers.isNotEmpty || speaker != null;

  /// [speakers], falling back to the single legacy [speaker].
  List<Speaker> get allSpeakers => [
    if (speakers.isNotEmpty) ...speakers else ?speaker,
  ];

  String get speakerNames {
    final names = [
      for (final person in speakers)
        if (person.name case final name? when name.isNotEmpty) name,
    ];
    if (names.isNotEmpty) return names.join(', ');
    return speaker?.name ?? '';
  }

  /// Agenda time label, or `HH:mm – HH:mm` (Warsaw time) built from dates.
  String get timeRangeLabel {
    if (timeLabel.isNotEmpty) return timeLabel;
    final start = startTime();
    final end = endTime();
    if (start.isEmpty) return '';
    return end.isEmpty ? start : '$start – $end';
  }

  String startTime() => ConferenceDateTime.formatHm(startDate);

  String endTime() => ConferenceDateTime.formatHm(endDate);
}
