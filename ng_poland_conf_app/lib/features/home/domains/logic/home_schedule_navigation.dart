import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/edition/domains/logic/edition_projections.dart';

enum HomeScheduleDestination { schedule, workshops }

class HomeScheduleNavTarget {
  const HomeScheduleNavTarget({
    required this.destination,
    required this.dayKey,
    this.track,
  });

  final HomeScheduleDestination destination;
  final String dayKey;
  final EventItemType? track;
}

class HomeScheduleNavigation {
  const HomeScheduleNavigation._();

  static HomeScheduleNavTarget? targetForDayKey(String key) {
    final track = trackForConferenceKey(key);
    if (track != null) {
      return HomeScheduleNavTarget(
        destination: HomeScheduleDestination.schedule,
        dayKey: key,
        track: track,
      );
    }
    if (key == 'workshops' || key == 'workshops2') {
      return HomeScheduleNavTarget(
        destination: HomeScheduleDestination.workshops,
        dayKey: key,
      );
    }
    return null;
  }
}
