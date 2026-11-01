import 'package:ng_poland_conf_app/features/edition/domain/entities/agenda.dart';

/// A workshop speaker with the role resolved from their profile.
typedef WorkshopSpeaker = ({SpeakerSummary speaker, String role});

/// A workshop with its display labels resolved.
class WorkshopListItem {
  const WorkshopListItem({
    required this.workshop,
    required this.conferenceLabel,
    required this.priceLabel,
    required this.speakers,
  });

  final WorkshopAgendaItem workshop;

  /// For example `NG POLAND 2026`.
  final String conferenceLabel;

  /// For example `499 PLN / 119 EUR`; empty when not priced.
  final String priceLabel;
  final List<WorkshopSpeaker> speakers;
}

/// One workshops day as shown in the bottom navigation.
class WorkshopDay {
  const WorkshopDay({
    required this.key,
    required this.tabLabel,
    required this.month,
    required this.dayOfMonth,
    required this.workshops,
  });

  final String key;

  /// Upper-case day name without the trailing `Day`.
  final String tabLabel;
  final String month;
  final String dayOfMonth;
  final List<WorkshopListItem> workshops;

  bool contains(int workshopId) =>
      workshops.any((item) => item.workshop.id == workshopId);
}
