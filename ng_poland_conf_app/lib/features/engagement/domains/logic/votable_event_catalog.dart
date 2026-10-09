import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/edition/domains/entities/edition.dart';
import 'package:ng_poland_conf_app/features/edition/domains/logic/edition_projections.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/votable_event.dart';

VotableEventCatalog votableEventsFromEdition(Edition edition) {
  final byId = <String, VotableEvent>{};
  var skippedWithoutEnd = 0;

  for (final track in EventItemType.values) {
    for (final item in eventItemsForTrack(edition: edition, track: track)) {
      if (item.isBreak || !item.hasSpeaker) continue;
      final endsAt = item.endDate?.toUtc();
      if (endsAt == null) {
        skippedWithoutEnd++;
        continue;
      }
      byId[item.id] = VotableEvent(
        eventId: item.id,
        endsAt: endsAt,
        track: track,
      );
    }
  }

  return VotableEventCatalog(
    events: byId.values.toList(),
    skippedWithoutEnd: skippedWithoutEnd,
  );
}

/// A talk can be liked at [endsAt] and after. Missing [endsAt] never qualifies.
bool eventHasEnded({required DateTime? endsAt, required DateTime now}) {
  if (endsAt == null) return false;
  return !now.toUtc().isBefore(endsAt.toUtc());
}

String votableSyncMessage(VotableEventCatalog catalog) {
  final count = catalog.events.length;
  final noun = count == 1 ? 'event' : 'events';
  final base = 'Synced $count votable $noun';
  final skipped = catalog.skippedWithoutEnd;
  if (skipped == 0) return base;
  final skippedNoun = skipped == 1 ? 'event' : 'events';
  return '$base ($skipped $skippedNoun skipped without end time)';
}
