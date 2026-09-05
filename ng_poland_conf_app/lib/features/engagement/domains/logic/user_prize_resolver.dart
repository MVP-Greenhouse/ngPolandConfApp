import '../entities/contest_history_entry.dart';
import '../entities/contest_winner.dart';
import '../entities/user_prize.dart';

class UserPrizeResolver {
  const UserPrizeResolver._();
  static List<UserPrize> resolve({
    required String uid,
    required List<ContestHistoryEntry> history,
    required ContestWinner? activeWin,
    required String? activeContestId,
    required String activeContestName,
  }) {
    final prizes = <UserPrize>[];
    final seen = <String>{};
    for (final entry in history) {
      ContestWinner? mine;
      for (final w in entry.winners) {
        if (w.uid == uid) {
          mine = w;
          break;
        }
      }
      if (mine == null) continue;
      seen.add(entry.contestId);
      prizes.add(
        UserPrize(
          contestId: entry.contestId,
          contestName: entry.name,
          order: mine.order,
          finishedAt: entry.finishedAt,
        ),
      );
    }
    final activeId = activeContestId;
    if (activeWin != null &&
        activeId != null &&
        activeId.isNotEmpty &&
        !seen.contains(activeId)) {
      prizes.add(
        UserPrize(
          contestId: activeId,
          contestName: activeContestName,
          order: activeWin.order,
        ),
      );
    }
    prizes.sort((a, b) {
      final af = a.finishedAt;
      final bf = b.finishedAt;
      if (af == null && bf == null) return 0;
      if (af == null) return -1;
      if (bf == null) return 1;
      return bf.compareTo(af);
    });
    return prizes;
  }
}
