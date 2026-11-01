import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/services/event_vote_ranking.dart';

/// Live Top 5 of a track.
sealed class Top5Status {
  const Top5Status();
}

/// Top 5 is disabled for the track.
class Top5Hidden extends Top5Status {
  const Top5Hidden();
}

class Top5Loading extends Top5Status {
  const Top5Loading();
}

class Top5Board extends Top5Status {
  const Top5Board({
    required this.confId,
    required this.track,
    required this.votingOpen,
    required this.top,
    required this.myVotes,
  });

  final String confId;
  final EventItemType track;
  final bool votingOpen;
  final List<EventVoteRank> top;

  /// Event ids the signed-in user voted for (empty when signed out).
  final Set<String> myVotes;
}
