import '../entities/contest_participant.dart';
import '../entities/contest_status.dart';
import '../entities/contest_winner.dart';

abstract interface class ContestRepository {
  Stream<ContestParticipant?> watchMyParticipation({
    required String confId,
    required String uid,
  });

  Future<void> join({
    required String confId,
    required String uid,
    required String displayName,
    required String email,
  });

  Stream<List<ContestParticipant>> watchParticipants(String confId);

  Stream<ContestWinner?> watchMyWin({
    required String confId,
    required String uid,
  });

  Stream<List<ContestWinner>> watchWinners(String confId);

  Future<void> saveWinners({
    required String confId,
    required List<ContestWinner> winners,
  });

  Future<void> updateContestStatus({
    required String confId,
    required ContestStatus status,
  });
}
