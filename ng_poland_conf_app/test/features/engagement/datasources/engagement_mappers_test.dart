import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/engagement/datasources/data/engagement_mappers.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';

void main() {
  test('tracks map round-trip keeps voting and top5 flags', () {
    final config = EngagementMappers.configFromMap({
      'tracks': {
        'ngPoland': {
          'votingEnabled': true,
          'votingStartsAt': DateTime.utc(2026, 11, 20, 9),
          'votingEndsAt': DateTime.utc(2026, 11, 21, 18),
          'top5Enabled': true,
        },
        'jsPoland': {
          'votingEnabled': false,
          'top5Enabled': true,
        },
      },
      'contestEnabled': true,
    });
    expect(config.forTrack(EventItemType.ngPoland).votingEnabled, isTrue);
    expect(config.forTrack(EventItemType.ngPoland).top5Enabled, isTrue);
    expect(config.forTrack(EventItemType.jsPoland).votingEnabled, isFalse);
    expect(config.forTrack(EventItemType.jsPoland).top5Enabled, isTrue);
    expect(config.forTrack(EventItemType.aiPoland).votingEnabled, isFalse);

    final map = EngagementMappers.tracksToMap(config);
    expect(map['tracks']['ngPoland']['votingEnabled'], isTrue);
    expect(map.containsKey('contestStatus'), isFalse);
  });

  test('legacy flat fields apply to all tracks', () {
    final config = EngagementMappers.configFromMap({
      'votingEnabled': true,
      'votingStartsAt': DateTime.utc(2026, 11, 20, 9),
      'votingEndsAt': DateTime.utc(2026, 11, 21, 18),
      'top5Enabled': true,
      'contestEnabled': true,
    });
    expect(config.forTrack(EventItemType.ngPoland).votingEnabled, isTrue);
    expect(config.forTrack(EventItemType.jsPoland).top5Enabled, isTrue);
    expect(config.forTrack(EventItemType.aiPoland).votingEnabled, isTrue);
  });

  test('missing config map yields disabled defaults', () {
    final config = EngagementMappers.configFromMap(null);
    expect(config.forTrack(EventItemType.ngPoland).votingEnabled, isFalse);
    expect(config.forTrack(EventItemType.ngPoland).top5Enabled, isFalse);
  });

  test('isLikeFromMap accepts Firestore num as int', () {
    expect(EngagementMappers.isLikeFromMap({'value': 1.0}), isTrue);
    expect(EngagementMappers.isLikeFromMap({'value': -1}), isFalse);
  });

  test('config accepts Firestore timestamps in tracks', () {
    final start = DateTime.utc(2026, 11, 20, 9);
    final config = EngagementMappers.configFromMap({
      'tracks': {
        'ngPoland': {
          'votingStartsAt': Timestamp.fromDate(start),
        },
      },
    });
    expect(config.forTrack(EventItemType.ngPoland).votingStartsAt, start);
  });
}
