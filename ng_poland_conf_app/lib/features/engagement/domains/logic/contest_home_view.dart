import '../entities/contest_status.dart';
import '../entities/engagement_config.dart';

enum ContestHomeView { hidden, join, joined, winner, loser }

class ContestHomeViewResolver {
  const ContestHomeViewResolver._();

  static ContestHomeView resolve({
    required bool isLatestConference,
    required EngagementConfig config,
    required DateTime now,
    required bool isParticipant,
    required bool isWinner,
  }) {
    if (!isLatestConference) return ContestHomeView.hidden;
    if (isWinner) return ContestHomeView.winner;
    if (isParticipant) {
      if (config.contestStatus == ContestStatus.finished) {
        return ContestHomeView.loser;
      }
      if (config.isContestJoinOpen(now) ||
          config.contestStatus == ContestStatus.drawing) {
        return ContestHomeView.joined;
      }
    }
    if (config.isContestJoinOpen(now) && !isParticipant) {
      return ContestHomeView.join;
    }
    return ContestHomeView.hidden;
  }
}
