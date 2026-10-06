import 'package:ng_poland_conf_app/core/constants/event_types.dart';

class TrackEngagementConfig {
  const TrackEngagementConfig({
    required this.votingEnabled,
    required this.votingStartsAt,
    required this.votingEndsAt,
    required this.top5Enabled,
  });

  final bool votingEnabled;
  final DateTime votingStartsAt;
  final DateTime votingEndsAt;
  final bool top5Enabled;

  static final missing = TrackEngagementConfig(
    votingEnabled: false,
    votingStartsAt: DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
    votingEndsAt: DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
    top5Enabled: false,
  );

  bool isVotingOpen(DateTime now) {
    return votingEnabled && _inWindow(now, votingStartsAt, votingEndsAt);
  }

  TrackEngagementConfig copyWith({
    bool? votingEnabled,
    DateTime? votingStartsAt,
    DateTime? votingEndsAt,
    bool? top5Enabled,
  }) {
    return TrackEngagementConfig(
      votingEnabled: votingEnabled ?? this.votingEnabled,
      votingStartsAt: votingStartsAt ?? this.votingStartsAt,
      votingEndsAt: votingEndsAt ?? this.votingEndsAt,
      top5Enabled: top5Enabled ?? this.top5Enabled,
    );
  }

  static bool _inWindow(DateTime now, DateTime start, DateTime end) {
    return !now.isBefore(start) && !now.isAfter(end);
  }
}

class EngagementConfig {
  const EngagementConfig({required this.tracks});

  final Map<EventItemType, TrackEngagementConfig> tracks;

  static final missing = EngagementConfig(tracks: const {});

  TrackEngagementConfig forTrack(EventItemType track) {
    return tracks[track] ?? TrackEngagementConfig.missing;
  }

  EngagementConfig withTrack(
    EventItemType track,
    TrackEngagementConfig config,
  ) {
    return EngagementConfig(
      tracks: {
        ...tracks,
        track: config,
      },
    );
  }
}
