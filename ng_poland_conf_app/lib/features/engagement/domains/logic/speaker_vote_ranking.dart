class SpeakerVoteRank {
  const SpeakerVoteRank({
    required this.speakerId,
    required this.name,
    required this.up,
    required this.down,
  });
  final String speakerId;
  final String name;
  final int up;
  final int down;
}

class SpeakerVoteRanking {
  const SpeakerVoteRanking._();

  static List<SpeakerVoteRank> sort(List<SpeakerVoteRank> input) {
    final copy = [...input];
    copy.sort((a, b) {
      final byUp = b.up.compareTo(a.up);
      if (byUp != 0) return byUp;
      return a.down.compareTo(b.down);
    });
    return copy;
  }
}
