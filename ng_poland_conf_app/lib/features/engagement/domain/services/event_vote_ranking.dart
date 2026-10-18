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

  EventVoteRank withLikes(int likes) => EventVoteRank(
    eventId: eventId,
    title: title,
    speakerName: speakerName,
    trackType: trackType,
    likes: likes,
    timeLabel: timeLabel,
    endsAt: endsAt,
  );
}

class EventVoteRanking {
  const EventVoteRanking._();

  static List<EventVoteRank> sort(List<EventVoteRank> input) =>
      [...input]..sort(_compare);

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

  static String voteCountLabel(int likes) =>
      likes == 1 ? '1 vote' : '$likes votes';

  static int _compare(EventVoteRank a, EventVoteRank b) {
    final byLikes = b.likes.compareTo(a.likes);
    if (byLikes != 0) return byLikes;
    final byTitle = a.title.compareTo(b.title);
    if (byTitle != 0) return byTitle;
    return a.eventId.compareTo(b.eventId);
  }
}
