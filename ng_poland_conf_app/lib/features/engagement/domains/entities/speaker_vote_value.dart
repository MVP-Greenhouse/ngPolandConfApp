enum SpeakerVoteValue {
  up,
  down;

  int get firestoreValue => switch (this) {
        SpeakerVoteValue.up => 1,
        SpeakerVoteValue.down => -1,
      };

  static SpeakerVoteValue? fromFirestore(int? value) {
    return switch (value) {
      1 => SpeakerVoteValue.up,
      -1 => SpeakerVoteValue.down,
      _ => null,
    };
  }
}
