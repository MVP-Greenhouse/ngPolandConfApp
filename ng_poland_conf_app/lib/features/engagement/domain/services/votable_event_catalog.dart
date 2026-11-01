import 'package:ng_poland_conf_app/features/edition/domain/entities/edition.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/edition/domain/services/edition_projections.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/entities/votable_event.dart';

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

/// A vote can always be withdrawn; a new one only once the talk has ended.
bool canToggleVote({
  required bool votedByMe,
  required DateTime? endsAt,
  required DateTime now,
}) => votedByMe || eventHasEnded(endsAt: endsAt, now: now);

String votableSyncMessage(VotableEventCatalog catalog) {
  final count = catalog.events.length;
  final noun = count == 1 ? 'event' : 'events';
  final base = 'Synced $count votable $noun';
  final skipped = catalog.skippedWithoutEnd;
  if (skipped == 0) return base;
  final skippedNoun = skipped == 1 ? 'event' : 'events';
  return '$base ($skipped $skippedNoun skipped without end time)';
}
