import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/domain/use_case.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/edition/domain/repositories/edition_repository.dart';
import 'package:ng_poland_conf_app/features/edition/domain/services/edition_projections.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/repositories/event_vote_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/repositories/votable_event_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/services/event_vote_ranking.dart';

/// Talks of a track that received votes, most voted first.
@injectable
class LoadVoteRanking
    implements UseCase<List<EventVoteRank>, LoadVoteRankingParams> {
  const LoadVoteRanking(this._editions, this._votes, this._votableEvents);

  final EditionRepository _editions;
  final EventVoteRepository _votes;
  final VotableEventRepository _votableEvents;

  @override
  Future<List<EventVoteRank>> call(LoadVoteRankingParams params) async {
    final edition = await _editions.load();
    final counts = await _votes.loadVoteCounts(params.confId);
    final catalog = await _votableEvents.loadEvents(params.confId);
    final events = eventItemsForConferenceTrack(
      edition: edition,
      confId: params.confId,
      track: params.track,
    );
    return EventVoteRanking.sort([
      for (final event in events)
        if (event.hasSpeaker && !event.isBreak)
          if (counts[event.id]?.likes case final likes? when likes > 0)
            EventVoteRank(
              eventId: event.id,
              title: event.title,
              speakerName: event.speakerNames,
              trackType: event.type,
              likes: likes,
              timeLabel: event.timeRangeLabel,
              endsAt: catalog[event.id]?.endsAt,
            ),
    ]);
  }
}

class LoadVoteRankingParams {
  const LoadVoteRankingParams({required this.confId, required this.track});

  final String confId;
  final EventItemType track;
}
