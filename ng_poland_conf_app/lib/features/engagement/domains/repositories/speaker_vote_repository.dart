import '../entities/speaker_vote_counts.dart';
import '../entities/speaker_vote_value.dart';

abstract interface class SpeakerVoteRepository {
  Stream<SpeakerVoteValue?> watchMyVote({
    required String confId,
    required String speakerId,
    required String uid,
  });

  Future<void> setVote({
    required String confId,
    required String speakerId,
    required String uid,
    SpeakerVoteValue? value,
  });

  Stream<Map<String, SpeakerVoteValue>> watchAllVotes({
    required String confId,
    required String speakerId,
  });

  Future<Map<String, SpeakerVoteCounts>> loadVoteCounts(String confId);
}
