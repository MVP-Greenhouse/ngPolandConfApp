import 'package:ng_poland_conf_app/features/edition/domains/entities/agenda.dart';
import 'package:ng_poland_conf_app/features/edition/domains/entities/speaker_profile.dart';

class Edition {
  const Edition({
    required this.year,
    required this.venue,
    required this.ticketsUrl,
    required this.days,
    required this.speakers,
  });

  final int year;
  final Venue? venue;
  final String ticketsUrl;
  final List<AgendaDay> days;
  final List<SpeakerProfile> speakers;

  String get confId => '$year';

  SpeakerProfile? speakerBySlug(String slug, {String conference = ''}) {
    SpeakerProfile? fallback;
    for (final speaker in speakers) {
      if (speaker.slug != slug) continue;
      if (conference.isNotEmpty && speaker.conference == conference) {
        return speaker;
      }
      fallback ??= speaker;
    }
    return fallback;
  }

  AgendaDay? dayByKey(String key) {
    for (final day in days) {
      if (day.key == key) return day;
    }
    return null;
  }

  ConferenceAgendaItem? conferenceItemById(String eventId) {
    for (final day in days) {
      for (final item in day.conferenceItems) {
        if (item.eventId == eventId) return item;
      }
    }
    return null;
  }
}

class HomeScheduleRow {
  const HomeScheduleRow({
    required this.key,
    required this.name,
    required this.dateLabel,
    required this.isWorkshops,
    required this.published,
  });

  final String key;
  final String name;
  final String dateLabel;
  final bool isWorkshops;
  final bool published;
}

List<HomeScheduleRow> homeScheduleRows(Edition edition) => [
  for (final day in edition.days)
    HomeScheduleRow(
      key: day.key,
      name: day.homeName,
      dateLabel: day.dateLabel,
      isWorkshops: day.kind == AgendaDayKind.workshops,
      published: day.published,
    ),
];
