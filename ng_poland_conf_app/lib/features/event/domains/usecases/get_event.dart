import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/core/usecases/usecases.dart';
import 'package:ng_poland_conf_app/features/edition/datasources/repositories/edition_repository.dart';
import 'package:ng_poland_conf_app/features/edition/domains/logic/edition_projections.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/entities/event_item.dart';

@injectable
class GetEvent implements UseCase<EventItem, Params> {
  GetEvent(this._editions);

  final EditionRepository _editions;

  @override
  Future<EventItem> call(Params params) async {
    final edition = await _editions.load();
    final track = EventItemType.values.asNameMap()[params.eventItemType];
    final events = edition == null || track == null
        ? const <EventItem>[]
        : eventItemsForTrack(edition: edition, track: track);
    return events.firstWhere((event) => event.id == params.eventId);
  }
}

class Params {
  final String eventId;
  final String eventItemType;

  Params({required this.eventId, required this.eventItemType});
}
