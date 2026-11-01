import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/domain/use_case.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/entities/track_engagement.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/repositories/engagement_config_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/services/voting_window.dart';
import 'package:ng_poland_conf_app/features/home/domain/repositories/conference_repository.dart';
import 'package:rxdart/rxdart.dart';

/// Voting / Top 5 availability of [EventItemType] in the current conference.
///
/// Re-emits when the admin changes the config and when the voting window
/// opens or closes.
@injectable
class WatchTrackEngagement
    implements StreamUseCase<TrackEngagement, EventItemType> {
  const WatchTrackEngagement(this._conferences, this._configs);

  final ConferenceRepository _conferences;
  final EngagementConfigRepository _configs;

  @override
  Stream<TrackEngagement> call(EventItemType track) => _conferences
      .watchCurrent()
      .map((conference) => conference.confId)
      .distinct()
      .switchMap(
        (confId) => _configs.watchConfig(confId).switchMap((config) {
          final trackConfig = config.forTrack(track);
          return watchVotingOpen(trackConfig).map(
            (votingOpen) => TrackEngagement(
              confId: confId,
              track: track,
              votingOpen: votingOpen,
              top5Enabled: trackConfig.top5Enabled,
            ),
          );
        }),
      );
}
