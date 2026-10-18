import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';

/// What engagement features are live for a track of the current conference.
class TrackEngagement {
  const TrackEngagement({
    required this.confId,
    required this.track,
    required this.votingOpen,
    required this.top5Enabled,
  });

  final String confId;
  final EventItemType track;
  final bool votingOpen;
  final bool top5Enabled;
}
