enum AgendaDayKind { conference, workshops }

class Venue {
  const Venue({
    required this.name,
    required this.address,
    required this.mapsUrl,
  });

  final String name;
  final String address;
  final String mapsUrl;
}

class SpeakerSummary {
  const SpeakerSummary({
    required this.name,
    required this.slug,
    required this.position,
    required this.company,
    required this.photo,
    required this.url,
  });

  final String name;
  final String slug;
  final String position;
  final String company;
  final String photo;
  final String? url;

  String get roleLabel {
    final parts = [
      if (position.isNotEmpty) position,
      if (company.isNotEmpty) company,
    ];
    return parts.join(', ');
  }
}

class ConferenceAgendaItem {
  const ConferenceAgendaItem({
    required this.id,
    required this.type,
    required this.icon,
    required this.isBreak,
    required this.session,
    required this.sessionLabel,
    required this.start,
    required this.end,
    required this.timeLabel,
    required this.title,
    required this.descriptionHtml,
    required this.description,
    required this.speakers,
    required this.dayDate,
  });

  final int id;
  final String type;
  final String icon;
  final bool isBreak;
  final int? session;
  final String sessionLabel;
  final String start;
  final String end;
  final String timeLabel;
  final String title;
  final String descriptionHtml;
  final String description;
  final List<SpeakerSummary> speakers;
  final String dayDate;

  String get eventId => '$id';

  bool get isVotable => !isBreak && speakers.isNotEmpty;
}

class WorkshopAgendaItem {
  const WorkshopAgendaItem({
    required this.id,
    required this.conference,
    required this.conferenceLabel,
    required this.color,
    required this.title,
    required this.cardTitle,
    required this.level,
    required this.benefits,
    required this.descriptionHtml,
    required this.description,
    required this.lunchProvided,
    required this.pricePln,
    required this.priceEur,
    required this.buyUrl,
    required this.speakers,
    required this.url,
    required this.timeLabel,
  });

  final int id;
  final String conference;
  final String conferenceLabel;
  final String color;
  final String title;
  final String cardTitle;
  final String level;
  final List<String> benefits;
  final String descriptionHtml;
  final String description;
  final bool lunchProvided;
  final int? pricePln;
  final int? priceEur;
  final String buyUrl;
  final List<SpeakerSummary> speakers;
  final String url;
  final String timeLabel;

  String get displayTitle => cardTitle.isNotEmpty ? cardTitle : title;
}

class AgendaDay {
  const AgendaDay({
    required this.key,
    required this.kind,
    required this.conference,
    required this.label,
    required this.title,
    required this.date,
    required this.dateLabel,
    required this.color,
    required this.published,
    required this.start,
    required this.conferenceItems,
    required this.workshopItems,
  });

  final String key;
  final AgendaDayKind kind;
  final String? conference;
  final String label;
  final String title;
  final String date;
  final String dateLabel;
  final String color;
  final bool published;
  final String start;
  final List<ConferenceAgendaItem> conferenceItems;
  final List<WorkshopAgendaItem> workshopItems;

  String get homeName {
    if (kind == AgendaDayKind.workshops && title.isNotEmpty) return title;
    return label;
  }
}
