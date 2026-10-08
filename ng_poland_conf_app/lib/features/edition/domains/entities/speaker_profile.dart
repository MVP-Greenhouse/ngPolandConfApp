class SpeakerSocial {
  const SpeakerSocial({required this.network, required this.url});

  final String network;
  final String url;
}

class SpeakerTalk {
  const SpeakerTalk({
    required this.title,
    required this.descriptionHtml,
    required this.description,
  });

  final String title;
  final String descriptionHtml;
  final String description;
}

class SpeakerBook {
  const SpeakerBook({required this.cover, required this.url});

  final String cover;
  final String? url;
}

class SpeakerVideo {
  const SpeakerVideo({
    required this.youtubeId,
    required this.url,
    required this.thumbnail,
  });

  final String youtubeId;
  final String url;
  final String thumbnail;
}

class SpeakerWorkshopRef {
  const SpeakerWorkshopRef({
    required this.id,
    required this.title,
    required this.url,
    this.level = '',
    this.date = '',
    this.conference = '',
  });

  final int id;
  final String title;
  final String url;
  final String level;
  final String date;
  final String conference;
}

/// One card per title. When the same workshop is listed for several
/// conferences, keep the session that matches [conference].
List<SpeakerWorkshopRef> uniqueSpeakerWorkshops(
  List<SpeakerWorkshopRef> workshops, {
  required String conference,
}) {
  final order = <String>[];
  final chosen = <String, SpeakerWorkshopRef>{};
  for (final workshop in workshops) {
    final current = chosen[workshop.title];
    if (current == null) {
      order.add(workshop.title);
      chosen[workshop.title] = workshop;
      continue;
    }
    final matches = conference.isNotEmpty && workshop.conference == conference;
    final currentMatches =
        conference.isNotEmpty && current.conference == conference;
    if (matches && !currentMatches) {
      chosen[workshop.title] = workshop;
    }
  }
  return [for (final title in order) ?chosen[title]];
}

class SpeakerAgendaRef {
  const SpeakerAgendaRef({
    required this.id,
    required this.title,
    required this.conference,
  });

  final int id;
  final String title;
  final String conference;

  String get eventId => '$id';
}

class SpeakerProfile {
  const SpeakerProfile({
    required this.id,
    required this.slug,
    required this.name,
    required this.conference,
    required this.conferenceLabel,
    required this.color,
    required this.position,
    required this.company,
    required this.country,
    required this.photo,
    required this.bioHtml,
    required this.bio,
    required this.talk,
    required this.socials,
    required this.books,
    required this.videos,
    required this.workshops,
    required this.agendaItems,
  });

  final int id;
  final String slug;
  final String name;
  final String conference;
  final String conferenceLabel;
  final String color;
  final String position;
  final String company;
  final String country;
  final String photo;
  final String bioHtml;
  final String bio;
  final SpeakerTalk? talk;
  final List<SpeakerSocial> socials;
  final List<SpeakerBook> books;
  final List<SpeakerVideo> videos;
  final List<SpeakerWorkshopRef> workshops;
  final List<SpeakerAgendaRef> agendaItems;

  String get roleLabel {
    final parts = [
      if (position.isNotEmpty) position,
      if (company.isNotEmpty) company,
    ];
    return parts.join(', ');
  }
}
