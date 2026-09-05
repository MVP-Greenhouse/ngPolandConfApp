import '../entities/contest_history_entry.dart';
import '../entities/contest_winner.dart';

class ContestArchive {
  const ContestArchive._();
  static ContestHistoryEntry buildEntry({
    required String contestId,
    required String name,
    required DateTime startsAt,
    required DateTime endsAt,
    required DateTime finishedAt,
    required List<ContestWinner> winners,
  }) {
    return ContestHistoryEntry(
      contestId: contestId,
      name: name,
      startsAt: startsAt,
      endsAt: endsAt,
      finishedAt: finishedAt,
      winners: List.unmodifiable(winners),
    );
  }
}
