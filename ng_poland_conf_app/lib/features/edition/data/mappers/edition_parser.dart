import 'dart:convert';

import 'package:ng_poland_conf_app/core/data/json_object.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/agenda.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/edition.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/speaker_profile.dart';

/// Raw bodies of the two ng-poland API resources that make up an edition.
typedef EditionBodies = ({String agenda, String speakers});

/// Decodes and parses [bodies]. Top-level so it can run in an isolate via
/// `compute`, keeping the large JSON payload off the UI thread.
Edition parseEditionBodies(EditionBodies bodies) => EditionParser.parse(
  agenda: _decode(bodies.agenda),
  speakers: _decode(bodies.speakers),
);

JsonObject _decode(String body) => switch (jsonDecode(body)) {
  final Map<Object?, Object?> map => JsonObject.from(map),
  _ => throw const FormatException('Edition payload is not a JSON object'),
};

class EditionParser {
  const EditionParser._();

  static Edition parse({
    required JsonObject agenda,
    required JsonObject speakers,
  }) {
    return Edition(
      year: agenda.integer('year') ?? speakers.integer('year') ?? 0,
      venue: _venue(agenda.object('venue')),
      ticketsUrl: agenda.string('ticketsUrl'),
      days: [for (final day in agenda.objects('days')) _day(day)],
      speakers: [
        for (final speaker in speakers.objects('speakers')) _speaker(speaker),
      ],
    );
  }

  static Venue? _venue(JsonObject json) {
    if (json.isEmpty) return null;
    return Venue(
      name: json.string('name'),
      address: json.string('address'),
      mapsUrl: json.string('mapsUrl'),
    );
  }

  static AgendaDay _day(JsonObject json) {
    final kind = json.string('kind') == 'workshops'
        ? AgendaDayKind.workshops
        : AgendaDayKind.conference;
    final date = json.string('date');
    final items = json.objects('items');
    return AgendaDay(
      key: json.string('key'),
      kind: kind,
      conference: json.optionalString('conference'),
      label: json.string('label'),
      title: json.string('title'),
      date: date,
      dateLabel: json.string('dateLabel'),
      color: json.string('color'),
      published: json.flag('published'),
      start: json.string('start'),
      conferenceItems: [
        if (kind == .conference)
          for (final item in items) _conferenceItem(item, date),
      ],
      workshopItems: [
        if (kind == .workshops)
          for (final item in items) _workshopItem(item),
      ],
    );
  }

  static ConferenceAgendaItem _conferenceItem(JsonObject json, String dayDate) {
    return ConferenceAgendaItem(
      id: json.integer('id') ?? 0,
      type: json.string('type'),
      icon: json.string('icon'),
      isBreak: json.flag('isBreak'),
      session: json.integer('session'),
      sessionLabel: json.string('sessionLabel'),
      start: json.string('start'),
      end: json.string('end'),
      timeLabel: json.string('timeLabel'),
      title: json.string('title'),
      descriptionHtml: json.string('descriptionHtml'),
      description: json.string('description'),
      speakers: _summaries(json),
      dayDate: dayDate,
    );
  }

  static WorkshopAgendaItem _workshopItem(JsonObject json) {
    return WorkshopAgendaItem(
      id: json.integer('id') ?? 0,
      conference: json.string('conference'),
      conferenceLabel: json.string('conferenceLabel'),
      color: json.string('color'),
      title: json.string('title'),
      cardTitle: json.string('cardTitle'),
      level: json.string('level'),
      benefits: [
        for (final benefit in json.list('benefits'))
          if (benefit case final String text when text.isNotEmpty) text,
      ],
      descriptionHtml: json.string('descriptionHtml'),
      description: json.string('description'),
      lunchProvided: json.flag('lunchProvided'),
      pricePln: json.integer('pricePln'),
      priceEur: json.integer('priceEur'),
      buyUrl: json.string('buyUrl'),
      speakers: _summaries(json),
      url: json.string('url'),
      timeLabel: json.string('timeLabel'),
    );
  }

  static SpeakerProfile _speaker(JsonObject json) {
    final talk = json.object('talk');
    return SpeakerProfile(
      id: json.integer('id') ?? 0,
      slug: json.string('slug'),
      name: json.string('name'),
      conference: json.string('conference'),
      conferenceLabel: json.string('conferenceLabel'),
      color: json.string('color'),
      position: json.string('position'),
      company: json.string('company'),
      country: json.string('country'),
      photo: json.string('photo'),
      bioHtml: json.string('bioHtml'),
      bio: json.string('bio'),
      talk: talk.isEmpty
          ? null
          : SpeakerTalk(
              title: talk.string('title'),
              descriptionHtml: talk.string('descriptionHtml'),
              description: talk.string('description'),
            ),
      socials: [
        for (final social in json.objects('socials'))
          SpeakerSocial(
            network: social.string('network'),
            url: social.string('url'),
          ),
      ],
      books: [
        for (final book in json.objects('books'))
          SpeakerBook(
            cover: book.string('cover'),
            url: book.optionalString('url'),
          ),
      ],
      videos: [
        for (final video in json.objects('videos'))
          SpeakerVideo(
            youtubeId: video.string('youtubeId'),
            url: video.string('url'),
            thumbnail: video.string('thumbnail'),
          ),
      ],
      workshops: [
        for (final workshop in json.objects('workshops'))
          SpeakerWorkshopRef(
            id: workshop.integer('id') ?? 0,
            title: workshop.string('title'),
            url: workshop.string('url'),
            level: workshop.string('level'),
            date: workshop.string('date'),
            conference: workshop.string('conference'),
          ),
      ],
      agendaItems: [
        for (final item in json.objects('agendaItems'))
          SpeakerAgendaRef(
            id: item.integer('id') ?? 0,
            title: item.string('title'),
            conference: item.string('conference'),
          ),
      ],
    );
  }

  static List<SpeakerSummary> _summaries(JsonObject json) => [
    for (final speaker in json.objects('speakers'))
      SpeakerSummary(
        name: speaker.string('name'),
        slug: speaker.string('slug'),
        position: speaker.string('position'),
        company: speaker.string('company'),
        photo: speaker.string('photo'),
        url: speaker.optionalString('url'),
      ),
  ];
}
