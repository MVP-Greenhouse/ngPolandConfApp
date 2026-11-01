import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';

/// First edition that had the AI Poland track.
const aiPolandSinceYear = 2025;

/// Tracks held at the conference [confId] (the edition year).
List<EventItemType> tracksForConference(String? confId) {
  final year = int.tryParse(confId ?? '');
  if (year == null) return const [];
  return [
    for (final track in EventItemType.values)
      if (track != .aiPoland || year >= aiPolandSinceYear) track,
  ];
}

/// Name of the conference shown in the app bar.
String conferenceDisplayName(String? confId) =>
    tracksForConference(confId).contains(EventItemType.aiPoland)
    ? 'NG & JS & AI Poland'
    : 'NG & JS Poland';
