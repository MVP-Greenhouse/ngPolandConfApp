import 'package:ng_poland_conf_app/core/constants/event_types.dart';

enum HomeScheduleDestination { schedule, workshops }

class HomeScheduleNavTarget {
  const HomeScheduleNavTarget({
    required this.destination,
    required this.track,
  });

  final HomeScheduleDestination destination;
  final EventItemType track;
}

/// Maps CMS `conferenceHomePageSchedule` item names to Schedule/Workshops + track.
/// Same convention as the previous app (NG/JS), extended with AI.
class HomeScheduleNavigation {
  const HomeScheduleNavigation._();

  static HomeScheduleNavTarget? targetForName(String name) {
    switch (name.trim().toLowerCase()) {
      case 'ng poland':
        return const HomeScheduleNavTarget(
          destination: HomeScheduleDestination.schedule,
          track: EventItemType.ngPoland,
        );
      case 'js poland':
        return const HomeScheduleNavTarget(
          destination: HomeScheduleDestination.schedule,
          track: EventItemType.jsPoland,
        );
      case 'ai poland':
        return const HomeScheduleNavTarget(
          destination: HomeScheduleDestination.schedule,
          track: EventItemType.aiPoland,
        );
      // CMS often uses a single "WORKSHOPS" day entry (see 2025 home).
      case 'workshops':
      case 'ng workshops':
        return const HomeScheduleNavTarget(
          destination: HomeScheduleDestination.workshops,
          track: EventItemType.ngPoland,
        );
      case 'js workshops':
        return const HomeScheduleNavTarget(
          destination: HomeScheduleDestination.workshops,
          track: EventItemType.jsPoland,
        );
      case 'ai workshops':
        return const HomeScheduleNavTarget(
          destination: HomeScheduleDestination.workshops,
          track: EventItemType.aiPoland,
        );
      default:
        return null;
    }
  }
}
