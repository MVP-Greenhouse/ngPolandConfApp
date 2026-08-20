import '../entities/speaker_vote_value.dart';

class SpeakerVoteToggle {
  const SpeakerVoteToggle._();

  static SpeakerVoteValue? apply({
    SpeakerVoteValue? current,
    required SpeakerVoteValue tapped,
  }) {
    if (current == tapped) return null;
    return tapped;
  }
}
