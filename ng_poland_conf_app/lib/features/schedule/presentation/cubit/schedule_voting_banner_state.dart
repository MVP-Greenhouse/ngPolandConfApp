part of 'schedule_voting_banner_cubit.dart';

sealed class ScheduleVotingBannerState {
  const ScheduleVotingBannerState();
}

class VotingBannerHidden extends ScheduleVotingBannerState {
  const VotingBannerHidden();
}

class VotingBannerVisible extends ScheduleVotingBannerState {
  const VotingBannerVisible({
    required this.votingOpen,
    required this.top5Enabled,
  });

  final bool votingOpen;
  final bool top5Enabled;
}
