import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/domain/use_case.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/edition/domain/repositories/edition_repository.dart';
import 'package:ng_poland_conf_app/features/edition/domain/services/edition_projections.dart';
import 'package:ng_poland_conf_app/features/schedule/domain/entities/track_schedule.dart';

@injectable
class GetTrackSchedule implements UseCase<TrackSchedule, EventItemType> {
  const GetTrackSchedule(this._editions);

  final EditionRepository _editions;

  @override
  Future<TrackSchedule> call(EventItemType track) async {
    final edition = await _editions.load();
    return TrackSchedule(
      events: eventItemsForTrack(edition: edition, track: track),
      published: conferenceDayForTrack(edition, track)?.published ?? true,
    );
  }
}
