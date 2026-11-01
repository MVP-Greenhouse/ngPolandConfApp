part of 'schedule_cubit.dart';

sealed class ScheduleState {
  const ScheduleState(this.track);

  final EventItemType track;
}

class ScheduleLoading extends ScheduleState {
  const ScheduleLoading(super.track);
}

class ScheduleLoaded extends ScheduleState {
  const ScheduleLoaded(super.track, this.schedule);

  final TrackSchedule schedule;
}

class ScheduleFailed extends ScheduleState {
  const ScheduleFailed(super.track);
}
