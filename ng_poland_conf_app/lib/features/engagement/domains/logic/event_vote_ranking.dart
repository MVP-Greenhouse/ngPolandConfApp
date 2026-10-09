class EventVoteRank {
  const EventVoteRank({
    required this.eventId,
    required this.title,
    required this.speakerName,
    required this.trackType,
    required this.likes,
    this.timeLabel = '',
    this.endsAt,
  });

  final String eventId;
  final String title;
  final String speakerName;
  final String trackType;
  final int likes;
  final String timeLabel;
  final DateTime? endsAt;
}

class EventVoteRanking {
  const EventVoteRanking._();

  static List<EventVoteRank> sort(List<EventVoteRank> input) {
    final copy = [...input];
    copy.sort(_compare);
    return copy;
  }

  static List<EventVoteRank> topForTrack({
    required List<EventVoteRank> input,
    required String trackType,
    int limit = 5,
  }) {
    final filtered = input
        .where((entry) => entry.trackType == trackType && entry.likes > 0)
        .toList();
    return sort(filtered).take(limit).toList();
  }

  static String voteCountLabel(int likes) {
    if (likes == 1) return '1 vote';
    return '$likes votes';
  }

  static int _compare(EventVoteRank a, EventVoteRank b) {
    final byLikes = b.likes.compareTo(a.likes);
    if (byLikes != 0) return byLikes;
    final byTitle = a.title.compareTo(b.title);
    if (byTitle != 0) return byTitle;
    return a.eventId.compareTo(b.eventId);
  }
}
