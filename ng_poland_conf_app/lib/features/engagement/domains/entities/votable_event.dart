import 'package:ng_poland_conf_app/core/constants/event_types.dart';

class VotableEvent {
  const VotableEvent({
    required this.eventId,
    required this.endsAt,
    required this.track,
  });

  final String eventId;
  final DateTime endsAt;
  final EventItemType track;
}

class VotableEventCatalog {
  const VotableEventCatalog({
    required this.events,
    required this.skippedWithoutEnd,
  });

  final List<VotableEvent> events;
  final int skippedWithoutEnd;
}
