import 'package:collection/collection.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/agenda.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/conference.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/conference_item.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/edition.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/speaker.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/speaker_profile.dart';
import 'package:ng_poland_conf_app/features/edition/domain/services/conference_datetime.dart';
import 'package:ng_poland_conf_app/features/edition/domain/services/conference_tracks.dart';

const editionTagline = 'The Biggest Angular Conference';

AgendaDay? conferenceDayForTrack(Edition edition, EventItemType type) =>
    edition.dayByKey(type.conferenceKey);

DateTime? editionStartsAt(Edition edition) {
  if (edition.days.isEmpty) return null;
  final first = edition.days.first;
  final hm = first.start.isNotEmpty ? first.start : '00:00';
  return ConferenceDateTime.combineWarsawDateAndHm(first.date, hm);
}

Conference conferenceFromEdition(Edition edition) {
  return Conference(
    confId: edition.confId,
    confName: conferenceDisplayName(edition.confId),
    description: editionTagline,
    startsAt: editionStartsAt(edition)?.toUtc(),
    listItems: [
      for (final row in homeScheduleRows(edition))
        ConferenceItem(key: row.key, name: row.name, desc: row.dateLabel),
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
      eventItemFromAgenda(item: item, confId: edition.confId, track: track),
  ];
}

List<EventItem> eventItemsForConferenceTrack({
  required Edition? edition,
  required String confId,
  required EventItemType track,
}) {
  if (edition == null || edition.confId != confId) return const [];
  return eventItemsForTrack(edition: edition, track: track);
}

EventItem eventItemFromAgenda({
  required ConferenceAgendaItem item,
  required String confId,
  required EventItemType track,
}) {
  final speakers = [
    for (final speaker in item.speakers) speakerFromSummary(speaker),
  ];
  return EventItem(
    id: item.eventId,
    title: item.title,
    confId: confId,
    type: track.name,
    category: item.type,
    shortDescription: item.sessionLabel.isEmpty ? null : item.sessionLabel,
    description: item.description.isEmpty ? null : item.description,
    startDate: ConferenceDateTime.combineWarsawDateAndHm(
      item.dayDate,
      item.start,
    ),
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
  String social(String network) =>
      profile.socials
          .firstWhereOrNull((item) => item.network == network)
          ?.url ??
      '';

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
