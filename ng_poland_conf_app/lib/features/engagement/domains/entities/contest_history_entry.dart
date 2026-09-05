import 'contest_winner.dart';

class ContestHistoryEntry {
  const ContestHistoryEntry({
    required this.contestId,
    required this.name,
    required this.startsAt,
    required this.endsAt,
    required this.finishedAt,
    required this.winners,
  });
  final String contestId;
  final String name;
  final DateTime startsAt;
  final DateTime endsAt;
  final DateTime finishedAt;
  final List<ContestWinner> winners;
}
