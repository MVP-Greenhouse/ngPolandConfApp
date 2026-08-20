import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/engagement/datasources/data/engagement_mappers.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_status.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/speaker_vote_value.dart';

void main() {
  test('config map round-trip keeps status and flags', () {
    final config = EngagementMappers.configFromMap({
      'votingEnabled': true,
      'votingStartsAt': DateTime.utc(2026, 11, 20, 9),
      'votingEndsAt': DateTime.utc(2026, 11, 21, 18),
      'contestEnabled': true,
      'contestStartsAt': DateTime.utc(2026, 11, 20, 12),
      'contestEndsAt': DateTime.utc(2026, 11, 20, 16),
      'contestStatus': 'open',
    });
    expect(config.votingEnabled, isTrue);
    expect(config.contestStatus, ContestStatus.open);
    final map = EngagementMappers.configToMap(config);
    expect(map['contestStatus'], 'open');
    expect(map['votingEnabled'], isTrue);
  });

  test('missing config map yields disabled defaults', () {
    final config = EngagementMappers.configFromMap(null);
    expect(config.votingEnabled, isFalse);
    expect(config.contestEnabled, isFalse);
    expect(config.contestStatus, ContestStatus.idle);
  });

  test('voteFromMap accepts Firestore num as int', () {
    expect(
      EngagementMappers.voteFromMap({'value': 1.0}),
      SpeakerVoteValue.up,
    );
  });

  test('winnerFromMap accepts Firestore num as int', () {
    final winner = EngagementMappers.winnerFromMap('uid-1', {
      'displayName': 'Alice',
      'email': 'alice@example.com',
      'order': 2.0,
    });
    expect(winner?.order, 2);
  });
}
