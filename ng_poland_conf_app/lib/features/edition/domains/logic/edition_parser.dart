import 'package:ng_poland_conf_app/features/edition/domains/entities/agenda.dart';
import 'package:ng_poland_conf_app/features/edition/domains/entities/edition.dart';
import 'package:ng_poland_conf_app/features/edition/domains/entities/speaker_profile.dart';

class EditionParser {
  const EditionParser._();

  static Edition parse({
    required Map<String, dynamic> agenda,
    required Map<String, dynamic> speakers,
  }) {
    final year = _int(agenda['year']) ?? _int(speakers['year']) ?? 0;
    return Edition(
      year: year,
      venue: _venue(agenda['venue']),
      ticketsUrl: _str(agenda['ticketsUrl']),
      days: [
        for (final raw in _list(agenda['days']))
          if (_map(raw) case final day) _day(day),
      ],
      speakers: [
        for (final raw in _list(speakers['speakers']))
          if (_map(raw) case final speaker) _speaker(speaker),
      ],
    );
  }

  static Venue? _venue(dynamic raw) {
    final map = _map(raw);
    if (map.isEmpty) return null;
    return Venue(
      name: _str(map['name']),
      address: _str(map['address']),
      mapsUrl: _str(map['mapsUrl']),
    );
  }

  static AgendaDay _day(Map<String, dynamic> json) {
    final kind = json['kind'] == 'workshops'
        ? AgendaDayKind.workshops
        : AgendaDayKind.conference;
    final date = _str(json['date']);
    final items = _list(json['items']);
    return AgendaDay(
      key: _str(json['key']),
      kind: kind,
      conference: _str(json['conference']).isEmpty ? null : _str(json['conference']),
      label: _str(json['label']),
      title: _str(json['title']),
      date: date,
      dateLabel: _str(json['dateLabel']),
      color: _str(json['color']),
      published: json['published'] == true,
      start: _str(json['start']),
      conferenceItems: kind == AgendaDayKind.conference
          ? [
              for (final raw in items)
                if (_map(raw) case final item) _conferenceItem(item, date),
            ]
          : const [],
      workshopItems: kind == AgendaDayKind.workshops
          ? [
              for (final raw in items)
                if (_map(raw) case final item) _workshopItem(item),
            ]
          : const [],
    );
  }

  static ConferenceAgendaItem _conferenceItem(
    Map<String, dynamic> json,
    String dayDate,
  ) {
    return ConferenceAgendaItem(
      id: _int(json['id']) ?? 0,
      type: _str(json['type']),
      icon: _str(json['icon']),
      isBreak: json['isBreak'] == true,
      session: _int(json['session']),
      sessionLabel: _str(json['sessionLabel']),
      start: _str(json['start']),
      end: _str(json['end']),
      timeLabel: _str(json['timeLabel']),
      title: _str(json['title']),
      descriptionHtml: _str(json['descriptionHtml']),
      description: _str(json['description']),
      speakers: _summaries(json['speakers']),
      dayDate: dayDate,
    );
  }

  static WorkshopAgendaItem _workshopItem(Map<String, dynamic> json) {
    return WorkshopAgendaItem(
      id: _int(json['id']) ?? 0,
      conference: _str(json['conference']),
      conferenceLabel: _str(json['conferenceLabel']),
      color: _str(json['color']),
      title: _str(json['title']),
      cardTitle: _str(json['cardTitle']),
      level: _str(json['level']),
      benefits: [
        for (final benefit in _list(json['benefits']))
          if (benefit is String && benefit.isNotEmpty) benefit,
      ],
      descriptionHtml: _str(json['descriptionHtml']),
      description: _str(json['description']),
      lunchProvided: json['lunchProvided'] == true,
      pricePln: _int(json['pricePln']),
      priceEur: _int(json['priceEur']),
      buyUrl: _str(json['buyUrl']),
      speakers: _summaries(json['speakers']),
      url: _str(json['url']),
      timeLabel: _str(json['timeLabel']),
    );
  }

  static SpeakerProfile _speaker(Map<String, dynamic> json) {
    final talk = _map(json['talk']);
    return SpeakerProfile(
      id: _int(json['id']) ?? 0,
      slug: _str(json['slug']),
      name: _str(json['name']),
      conference: _str(json['conference']),
      conferenceLabel: _str(json['conferenceLabel']),
      color: _str(json['color']),
      position: _str(json['position']),
      company: _str(json['company']),
      country: _str(json['country']),
      photo: _str(json['photo']),
      bioHtml: _str(json['bioHtml']),
      bio: _str(json['bio']),
      talk: talk.isEmpty
          ? null
          : SpeakerTalk(
              title: _str(talk['title']),
              descriptionHtml: _str(talk['descriptionHtml']),
              description: _str(talk['description']),
            ),
      socials: [
        for (final raw in _list(json['socials']))
          if (_map(raw) case final social)
            SpeakerSocial(network: _str(social['network']), url: _str(social['url'])),
      ],
      books: [
        for (final raw in _list(json['books']))
          if (_map(raw) case final book)
            SpeakerBook(
              cover: _str(book['cover']),
              url: _str(book['url']).isEmpty ? null : _str(book['url']),
            ),
      ],
      videos: [
        for (final raw in _list(json['videos']))
          if (_map(raw) case final video)
            SpeakerVideo(
              youtubeId: _str(video['youtubeId']),
              url: _str(video['url']),
              thumbnail: _str(video['thumbnail']),
            ),
      ],
      workshops: [
        for (final raw in _list(json['workshops']))
          if (_map(raw) case final workshop)
            SpeakerWorkshopRef(
              id: _int(workshop['id']) ?? 0,
              title: _str(workshop['title']),
              url: _str(workshop['url']),
              level: _str(workshop['level']),
              date: _str(workshop['date']),
              conference: _str(workshop['conference']),
            ),
      ],
      agendaItems: [
        for (final raw in _list(json['agendaItems']))
          if (_map(raw) case final item)
            SpeakerAgendaRef(
              id: _int(item['id']) ?? 0,
              title: _str(item['title']),
              conference: _str(item['conference']),
            ),
      ],
    );
  }

  static List<SpeakerSummary> _summaries(dynamic raw) => [
    for (final item in _list(raw))
      if (_map(item) case final speaker)
        SpeakerSummary(
          name: _str(speaker['name']),
          slug: _str(speaker['slug']),
          position: _str(speaker['position']),
          company: _str(speaker['company']),
          photo: _str(speaker['photo']),
          url: _str(speaker['url']).isEmpty ? null : _str(speaker['url']),
        ),
  ];

  static Map<String, dynamic> _map(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, item) => MapEntry('$key', item));
    }
    return const {};
  }

  static List<dynamic> _list(dynamic value) => value is List ? value : const [];

  static String _str(dynamic value) => value is String ? value : '';

  static int? _int(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }
}
