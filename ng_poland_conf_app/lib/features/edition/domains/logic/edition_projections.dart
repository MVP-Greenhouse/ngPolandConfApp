import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/edition/domains/entities/agenda.dart';
import 'package:ng_poland_conf_app/features/edition/domains/entities/edition.dart';
import 'package:ng_poland_conf_app/features/edition/domains/entities/speaker_profile.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conference.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conference_item.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/entities/event_item.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/logic/conference_datetime.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/entities/speaker.dart';

const editionTagline = 'The Biggest Angular Conference';

EventItemType? trackForConferenceKey(String? key) => switch (key) {
  'ng' => EventItemType.ngPoland,
  'js' => EventItemType.jsPoland,
  'ai' => EventItemType.aiPoland,
  _ => null,
};

String conferenceKeyForTrack(EventItemType type) => switch (type) {
  EventItemType.ngPoland => 'ng',
  EventItemType.jsPoland => 'js',
  EventItemType.aiPoland => 'ai',
};

AgendaDay? conferenceDayForTrack(Edition edition, EventItemType type) {
  final key = conferenceKeyForTrack(type);
  return edition.dayByKey(key);
}

DateTime? editionStartsAt(Edition edition) {
  if (edition.days.isEmpty) return null;
  final first = edition.days.first;
  final hm = first.start.isNotEmpty ? first.start : '00:00';
  return ConferenceDateTime.combineWarsawDateAndHm(first.date, hm);
}

Conference conferenceFromEdition(Edition edition) {
  final start = editionStartsAt(edition);
  return Conference(
    confId: edition.confId,
    confName: 'NG & JS & AI Poland',
    isCurrent: true,
    description: editionTagline,
    conferencesStartDate: start?.toUtc().toIso8601String(),
    listItems: [
      for (final row in homeScheduleRows(edition))
        ConferenceItem(name: row.name, desc: row.dateLabel),
    ],
  );
}

List<EventItem> eventItemsForTrack({
  required Edition edition,
  required EventItemType track,
}) {
  final day = conferenceDayForTrack(edition, track);
  if (day == null || !day.published) return const [];
  return [
    for (final item in day.conferenceItems)
      eventItemFromAgenda(
        item: item,
        confId: edition.confId,
        track: track,
      ),
  ];
}

EventItem eventItemFromAgenda({
  required ConferenceAgendaItem item,
  required String confId,
  required EventItemType track,
}) {
  final speakers = [for (final speaker in item.speakers) speakerFromSummary(speaker)];
  return EventItem(
    id: item.eventId,
    title: item.title,
    confId: confId,
    type: track.name,
    category: item.type,
    shortDescription: item.sessionLabel.isEmpty ? null : item.sessionLabel,
    description: item.description.isEmpty ? null : item.description,
    startDate: ConferenceDateTime.combineWarsawDateAndHm(item.dayDate, item.start),
    endDate: ConferenceDateTime.combineWarsawDateAndHm(item.dayDate, item.end),
    speaker: speakers.isEmpty ? null : speakers.first,
    speakers: speakers,
    isBreak: item.isBreak,
    sessionLabel: item.sessionLabel,
    timeLabel: item.timeLabel,
    icon: item.icon,
    descriptionHtml: item.descriptionHtml,
  );
}

Speaker speakerFromSummary(SpeakerSummary summary) => Speaker(
  id: summary.slug,
  name: summary.name,
  role: summary.roleLabel,
  bio: '',
  photoFileUrl: summary.photo,
  photoTitle: '',
  photoDescription: '',
  email: '',
  urlGithub: '',
  urlLinkedIn: '',
  urlTwitter: '',
  urlWww: summary.url ?? '',
);

Speaker speakerFromProfile(SpeakerProfile profile) {
  String social(String network) {
    for (final item in profile.socials) {
      if (item.network == network) return item.url;
    }
    return '';
  }

  return Speaker(
    id: profile.slug,
    name: profile.name,
    role: profile.roleLabel,
    bio: profile.bio,
    photoFileUrl: profile.photo,
    photoTitle: '',
    photoDescription: profile.talk?.title ?? '',
    email: '',
    urlGithub: social('github'),
    urlLinkedIn: social('linkedin'),
    urlTwitter: social('x'),
    urlWww: social('website'),
    conferenceKey: profile.conference,
    talkTitle: profile.talk?.title ?? '',
  );
}

List<Speaker> speakersFromEdition(Edition edition) => [
  for (final profile in edition.speakers) speakerFromProfile(profile),
];
