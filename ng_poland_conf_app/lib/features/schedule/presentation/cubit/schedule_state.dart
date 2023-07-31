part of 'schedule_cubit.dart';

@freezed
class ScheduleState with _$ScheduleState {
  const factory ScheduleState.initial() = _Initial;

  const factory ScheduleState.loading() = _Loading;

  const factory ScheduleState.loaded({
    required List<EventItem> listEvents,
  }) = _Loaded;

  const factory ScheduleState.error(String error) = _Error;
}
