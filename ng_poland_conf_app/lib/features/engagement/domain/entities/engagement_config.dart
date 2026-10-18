import 'package:collection/collection.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';

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

  /// Stored for voting window dates that were never configured.
  static final unsetTimestamp = DateTime.fromMillisecondsSinceEpoch(
    0,
    isUtc: true,
  );

  static final missing = TrackEngagementConfig(
    votingEnabled: false,
    votingStartsAt: unsetTimestamp,
    votingEndsAt: unsetTimestamp,
    top5Enabled: false,
  );

  static bool isUnset(DateTime value) =>
      value.millisecondsSinceEpoch == unsetTimestamp.millisecondsSinceEpoch;

  bool isVotingOpen(DateTime now) {
    return votingEnabled && _inWindow(now, votingStartsAt, votingEndsAt);
  }

  /// Next moment after [now] when [isVotingOpen] flips, if any.
  DateTime? nextWindowChangeAfter(DateTime now) {
    if (!votingEnabled) return null;
    final closesAt = votingEndsAt.add(const Duration(microseconds: 1));
    return [
      votingStartsAt,
      closesAt,
    ].where((moment) => moment.isAfter(now)).minOrNull;
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

  static const missing = EngagementConfig(tracks: {});

  TrackEngagementConfig forTrack(EventItemType track) {
    return tracks[track] ?? TrackEngagementConfig.missing;
  }

  EngagementConfig withTrack(
    EventItemType track,
    TrackEngagementConfig config,
  ) {
    return EngagementConfig(tracks: {...tracks, track: config});
  }
}
