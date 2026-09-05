import 'package:cloud_firestore/cloud_firestore.dart';
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

  test('config maps contestName and contestId', () {
    final config = EngagementMappers.configFromMap({
      'votingEnabled': true,
      'votingStartsAt': DateTime.utc(2026, 11, 20, 9),
      'votingEndsAt': DateTime.utc(2026, 11, 21, 18),
      'contestEnabled': true,
      'contestStartsAt': DateTime.utc(2026, 11, 20, 12),
      'contestEndsAt': DateTime.utc(2026, 11, 20, 16),
      'contestStatus': 'open',
      'contestName': 'Koszulki',
      'contestId': 'abc',
    });
    expect(config.contestName, 'Koszulki');
    expect(config.contestId, 'abc');
    final map = EngagementMappers.configToMap(config);
    expect(map['contestName'], 'Koszulki');
    expect(map['contestId'], 'abc');
  });

  test('history entry from map', () {
    final entry = EngagementMappers.historyFromMap('c1', {
      'name': 'Koszulki',
      'startsAt': DateTime.utc(2026, 1, 1),
      'endsAt': DateTime.utc(2026, 1, 2),
      'finishedAt': DateTime.utc(2026, 1, 3),
      'winners': [
        {'uid': 'u1', 'displayName': 'Ada', 'email': 'a@b.c', 'order': 1},
      ],
    });
    expect(entry?.name, 'Koszulki');
    expect(entry?.winners.single.uid, 'u1');
  });

  test('history entry accepts Firestore timestamps', () {
    final finishedAt = DateTime.utc(2026, 1, 3);
    final entry = EngagementMappers.historyFromMap('c1', {
      'finishedAt': Timestamp.fromDate(finishedAt),
    });
    expect(entry?.finishedAt, finishedAt);
  });

  test('history entry skips winner with non-string uid', () {
    final entry = EngagementMappers.historyFromMap('c1', {
      'winners': [
        {'uid': 123, 'displayName': 'Invalid'},
        {'uid': 'u1', 'displayName': 'Ada'},
      ],
    });

    expect(entry?.winners.map((winner) => winner.uid), ['u1']);
  });

  test('missing config map yields disabled defaults', () {
    final config = EngagementMappers.configFromMap(null);
    expect(config.votingEnabled, isFalse);
    expect(config.contestEnabled, isFalse);
    expect(config.contestStatus, ContestStatus.idle);
  });

  test('voteFromMap accepts Firestore num as int', () {
    expect(EngagementMappers.voteFromMap({'value': 1.0}), SpeakerVoteValue.up);
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
