import 'package:ng_poland_conf_app/features/engagement/domains/entities/votable_event.dart';

abstract interface class VotableEventRepository {
  Stream<VotableEvent?> watchEvent({
    required String confId,
    required String eventId,
  });

  Future<Map<String, VotableEvent>> loadEvents(String confId);

  Future<void> replaceCatalog({
    required String confId,
    required List<VotableEvent> events,
  });
}
