import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ng_poland_conf_app/core/data/json_object.dart';
import 'package:ng_poland_conf_app/core/utils/object_extensions.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/entities/engagement_config.dart';

class EngagementMappers {
  const EngagementMappers._();

  static EngagementConfig configFromMap(Map<String, dynamic>? data) {
    if (data == null) return EngagementConfig.missing;

    final tracksRaw = data['tracks'];
    if (tracksRaw is Map) {
      final tracks = <EventItemType, TrackEngagementConfig>{};
      for (final entry in tracksRaw.entries) {
        if ((entry.key, entry.value) case (
          final String key,
          final Map<Object?, Object?> value,
        )) {
          if (EventItemType.fromName(key) case final track?) {
            tracks[track] = _trackFromMap(Map<String, dynamic>.from(value));
          }
        }
      }
      return EngagementConfig(tracks: tracks);
    }

    // Legacy flat fields → apply as default for every known track.
    final legacy = _trackFromMap(data);
    if (_isMissingTrack(legacy)) return EngagementConfig.missing;
    return EngagementConfig(
      tracks: {for (final track in EventItemType.values) track: legacy},
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

  static int? readInt(Object? value) => value.castOrNull<num>()?.toInt();

  static TrackEngagementConfig _trackFromMap(Map<String, dynamic> data) {
    return TrackEngagementConfig(
      votingEnabled: JsonObject(data).flag('votingEnabled'),
      votingStartsAt: _dateTime(data['votingStartsAt']),
      votingEndsAt: _dateTime(data['votingEndsAt']),
      top5Enabled: JsonObject(data).flag('top5Enabled'),
    );
  }

  static bool _isMissingTrack(TrackEngagementConfig config) {
    return !config.votingEnabled &&
        !config.top5Enabled &&
        TrackEngagementConfig.isUnset(config.votingStartsAt) &&
        TrackEngagementConfig.isUnset(config.votingEndsAt);
  }

  static DateTime _dateTime(Object? value) => switch (value) {
    final DateTime dateTime => dateTime,
    final Timestamp timestamp => DateTime.fromMillisecondsSinceEpoch(
      timestamp.millisecondsSinceEpoch,
      isUtc: true,
    ),
    _ => TrackEngagementConfig.unsetTimestamp,
  };
}
