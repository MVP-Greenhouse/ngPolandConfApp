import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/home/domains/logic/home_schedule_navigation.dart';

void main() {
  test('maps NG/JS/AI poland to schedule tracks', () {
    expect(
      HomeScheduleNavigation.targetForName('NG Poland')?.track,
      EventItemType.ngPoland,
    );
    expect(
      HomeScheduleNavigation.targetForName('js poland')?.track,
      EventItemType.jsPoland,
    );
    expect(
      HomeScheduleNavigation.targetForName('AI Poland')?.destination,
      HomeScheduleDestination.schedule,
    );
  });

  test('maps workshops names to workshops + track', () {
    final plain = HomeScheduleNavigation.targetForName('WORKSHOPS');
    expect(plain?.destination, HomeScheduleDestination.workshops);
    expect(plain?.track, EventItemType.ngPoland);

    final ng = HomeScheduleNavigation.targetForName('NG Workshops');
    expect(ng?.destination, HomeScheduleDestination.workshops);
    expect(ng?.track, EventItemType.ngPoland);
    expect(
      HomeScheduleNavigation.targetForName('JS Workshops')?.track,
      EventItemType.jsPoland,
    );
  });

  test('unknown name returns null', () {
    expect(HomeScheduleNavigation.targetForName('Unknown'), isNull);
  });
}
