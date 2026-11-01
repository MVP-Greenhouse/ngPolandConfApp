import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/domain/use_case.dart';
import 'package:ng_poland_conf_app/features/edition/domain/repositories/edition_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/entities/votable_event.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/exceptions/engagement_exception.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/repositories/votable_event_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/services/votable_event_catalog.dart';

/// Rebuilds the list of votable talks of conference `confId` from a freshly
/// downloaded agenda.
@injectable
class SyncVotableEvents implements UseCase<VotableEventCatalog, String> {
  const SyncVotableEvents(this._editions, this._votableEvents);

  final EditionRepository _editions;
  final VotableEventRepository _votableEvents;

  @override
  Future<VotableEventCatalog> call(String confId) async {
    final edition = await _editions.refresh();
    if (edition.confId != confId) {
      throw EditionMismatchException(
        editionConfId: edition.confId,
        confId: confId,
      );
    }
    final catalog = votableEventsFromEdition(edition);
    await _votableEvents.replaceCatalog(confId: confId, events: catalog.events);
    return catalog;
  }
}
