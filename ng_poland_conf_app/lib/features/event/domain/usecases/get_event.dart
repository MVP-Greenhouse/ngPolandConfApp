import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/domain/use_case.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/edition/domain/repositories/edition_repository.dart';
import 'package:ng_poland_conf_app/features/edition/domain/services/edition_projections.dart';
import 'package:ng_poland_conf_app/features/event/domain/exceptions/event_not_found_exception.dart';

@injectable
class GetEvent implements UseCase<EventItem, GetEventParams> {
  const GetEvent(this._editions);

  final EditionRepository _editions;

  /// Throws [EventNotFoundException] when the agenda has no such session.
  @override
  Future<EventItem> call(GetEventParams params) async {
    final edition = await _editions.load();
    return eventItemsForTrack(
          edition: edition,
          track: params.track,
        ).firstWhereOrNull((event) => event.id == params.eventId) ??
        (throw const EventNotFoundException());
  }
}

class GetEventParams {
  const GetEventParams({required this.eventId, required this.track});

  final String eventId;
  final EventItemType track;
}
