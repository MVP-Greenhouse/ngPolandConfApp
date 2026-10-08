import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/edition/datasources/repositories/edition_repository.dart';
import 'package:ng_poland_conf_app/features/edition/domains/logic/edition_projections.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/entities/event_item.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/repositories/schedule_repository.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/usecases/get_all_events_for_conference.dart';

@Singleton(as: ScheduleRepository)
class ScheduleRepositoryImpl implements ScheduleRepository {
  ScheduleRepositoryImpl(this._editionRepository);

  final EditionRepository _editionRepository;

  @override
  Future<List<EventItem>> getAllEvents(Params params) async {
    final edition = await _editionRepository.load();
    if (edition == null || edition.confId != params.confId) return const [];
    final track = _track(params.eventItemType);
    if (track == null) return const [];
    return eventItemsForTrack(edition: edition, track: track);
  }

  EventItemType? _track(String name) {
    for (final type in EventItemType.values) {
      if (type.name == name) return type;
    }
    return null;
  }
}
