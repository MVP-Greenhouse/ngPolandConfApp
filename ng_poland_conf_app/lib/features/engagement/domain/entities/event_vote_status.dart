/// Whether and how the user can vote for a single talk.
sealed class EventVoteStatus {
  const EventVoteStatus();
}

/// Voting is closed, the talk is not votable, or the session is loading.
class EventVoteHidden extends EventVoteStatus {
  const EventVoteHidden();
}

class EventVoteNeedsLogin extends EventVoteStatus {
  const EventVoteNeedsLogin();
}

class EventVoteAvailable extends EventVoteStatus {
  const EventVoteAvailable({required this.liked});

  final bool liked;
}
