part of 'schedule_voting_banner_cubit.dart';

sealed class ScheduleVotingBannerState {
  const ScheduleVotingBannerState();

  const factory ScheduleVotingBannerState.hidden() = _Hidden;
  const factory ScheduleVotingBannerState.visible({
    required bool votingOpen,
    required bool top5Enabled,
  }) = _Visible;
}

final class _Hidden extends ScheduleVotingBannerState {
  const _Hidden();
}

final class _Visible extends ScheduleVotingBannerState {
  const _Visible({
    required this.votingOpen,
    required this.top5Enabled,
  });

  final bool votingOpen;
  final bool top5Enabled;
}

extension ScheduleVotingBannerStateX on ScheduleVotingBannerState {
  T maybeWhen<T>({
    T Function(bool votingOpen, bool top5Enabled)? visible,
    required T Function() orElse,
  }) {
    return switch (this) {
      _Visible(:final votingOpen, :final top5Enabled) when visible != null =>
        visible(votingOpen, top5Enabled),
      _ => orElse(),
    };
  }
}
