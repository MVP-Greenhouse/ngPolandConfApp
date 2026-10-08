import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/home/domains/logic/home_schedule_navigation.dart';

void main() {
  test('maps conference day keys to schedule tracks', () {
    expect(
      HomeScheduleNavigation.targetForDayKey('ng')?.track,
      EventItemType.ngPoland,
    );
    expect(
      HomeScheduleNavigation.targetForDayKey('js')?.track,
      EventItemType.jsPoland,
    );
    expect(
      HomeScheduleNavigation.targetForDayKey('ai')?.destination,
      HomeScheduleDestination.schedule,
    );
  });

  test('maps workshop day keys without a conference track', () {
    final first = HomeScheduleNavigation.targetForDayKey('workshops');
    expect(first?.destination, HomeScheduleDestination.workshops);
    expect(first?.track, isNull);

    final second = HomeScheduleNavigation.targetForDayKey('workshops2');
    expect(second?.destination, HomeScheduleDestination.workshops);
    expect(second?.dayKey, 'workshops2');
  });

  test('unknown key returns null', () {
    expect(HomeScheduleNavigation.targetForDayKey('unknown'), isNull);
  });
}
