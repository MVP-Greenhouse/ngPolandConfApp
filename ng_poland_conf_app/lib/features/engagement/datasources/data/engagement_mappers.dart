import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';

class EngagementMappers {
  const EngagementMappers._();

  static final DateTime _epochUtc = DateTime.fromMillisecondsSinceEpoch(
    0,
    isUtc: true,
  );

  static EngagementConfig configFromMap(Map<String, dynamic>? data) {
    if (data == null) return EngagementConfig.missing;

    final tracksRaw = data['tracks'];
    if (tracksRaw is Map) {
      final tracks = <EventItemType, TrackEngagementConfig>{};
      for (final entry in tracksRaw.entries) {
        final track = _trackFromKey(entry.key);
        if (track == null) continue;
        final value = entry.value;
        if (value is! Map) continue;
        tracks[track] = _trackFromMap(Map<String, dynamic>.from(value));
      }
      return EngagementConfig(tracks: tracks);
    }

    // Legacy flat fields → apply as default for every known track.
    final legacy = _trackFromMap(data);
    if (_isMissingTrack(legacy)) return EngagementConfig.missing;
    return EngagementConfig(
      tracks: {
        for (final track in EventItemType.values) track: legacy,
      },
    );
  }

  static Map<String, dynamic> tracksToMap(EngagementConfig config) {
    return {
      'tracks': {
        for (final entry in config.tracks.entries)
          entry.key.name: trackToMap(entry.value),
      },
    };
  }

  static Map<String, dynamic> trackToMap(TrackEngagementConfig config) {
    return {
      'votingEnabled': config.votingEnabled,
      'votingStartsAt': config.votingStartsAt,
      'votingEndsAt': config.votingEndsAt,
      'top5Enabled': config.top5Enabled,
    };
  }

  static bool isLikeFromMap(Map<String, dynamic>? data) {
    if (data == null) return false;
    final value = readInt(data['value']);
    return value == 1;
  }

  static int? readInt(Object? value) {
    return value is int ? value : (value is num ? value.toInt() : null);
  }

  static TrackEngagementConfig _trackFromMap(Map<String, dynamic> data) {
    return TrackEngagementConfig(
      votingEnabled: data['votingEnabled'] as bool? ?? false,
      votingStartsAt: _dateTime(data['votingStartsAt']),
      votingEndsAt: _dateTime(data['votingEndsAt']),
      top5Enabled: data['top5Enabled'] as bool? ?? false,
    );
  }

  static bool _isMissingTrack(TrackEngagementConfig config) {
    return !config.votingEnabled &&
        !config.top5Enabled &&
        config.votingStartsAt == _epochUtc &&
        config.votingEndsAt == _epochUtc;
  }

  static EventItemType? _trackFromKey(Object? key) {
    if (key is! String) return null;
    for (final track in EventItemType.values) {
      if (track.name == key) return track;
    }
    return null;
  }

  static DateTime _dateTime(dynamic value) {
    if (value is DateTime) return value;
    if (value is Timestamp) {
      return DateTime.fromMillisecondsSinceEpoch(
        value.millisecondsSinceEpoch,
        isUtc: true,
      );
    }
    return _epochUtc;
  }
}
