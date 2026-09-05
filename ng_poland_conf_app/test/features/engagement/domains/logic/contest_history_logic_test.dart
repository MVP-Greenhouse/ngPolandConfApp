import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_history_entry.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_status.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_winner.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/contest_archive.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/start_new_contest_guard.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/user_prize_resolver.dart';

void main() {
  final winner = ContestWinner(
    uid: 'u1',
    displayName: 'Ada',
    email: 'a@b.c',
    order: 1,
  );

  group('StartNewContestGuard', () {
    test('requires finished status', () {
      expect(
        StartNewContestGuard.validate(
          status: ContestStatus.open,
          name: 'Koszulki',
        ),
        'Konkurs musi być zakończony',
      );
    });

    test('requires non-empty name', () {
      expect(
        StartNewContestGuard.validate(
          status: ContestStatus.finished,
          name: '  ',
        ),
        'Podaj nazwę konkursu',
      );
    });

    test('ok when finished and named', () {
      expect(
        StartNewContestGuard.validate(
          status: ContestStatus.finished,
          name: 'Koszulki',
        ),
        isNull,
      );
    });
  });

  group('ContestArchive', () {
    test('builds snapshot including empty winners', () {
      final entry = ContestArchive.buildEntry(
        contestId: 'c1',
        name: 'Runda 1',
        startsAt: DateTime.utc(2026, 1, 1),
        endsAt: DateTime.utc(2026, 1, 2),
        finishedAt: DateTime.utc(2026, 1, 3),
        winners: const [],
      );
      expect(entry.contestId, 'c1');
      expect(entry.winners, isEmpty);
    });
  });

  group('UserPrizeResolver', () {
    test('includes history wins', () {
      final history = [
        ContestHistoryEntry(
          contestId: 'c1',
          name: 'Koszulki',
          startsAt: DateTime.utc(2026, 1, 1),
          endsAt: DateTime.utc(2026, 1, 2),
          finishedAt: DateTime.utc(2026, 1, 3),
          winners: [winner],
        ),
      ];
      final prizes = UserPrizeResolver.resolve(
        uid: 'u1',
        history: history,
        activeWin: null,
        activeContestId: 'c2',
        activeContestName: 'Gadżety',
      );
      expect(prizes.single.contestId, 'c1');
      expect(prizes.single.contestName, 'Koszulki');
      expect(prizes.single.order, 1);
    });

    test('adds active win only when contestId not in history', () {
      final prizes = UserPrizeResolver.resolve(
        uid: 'u1',
        history: const [],
        activeWin: winner,
        activeContestId: 'c2',
        activeContestName: 'Gadżety',
      );
      expect(prizes.single.contestId, 'c2');
    });

    test('dedupes duplicate history entries by contestId', () {
      final history = [
        ContestHistoryEntry(
          contestId: 'c1',
          name: 'Koszulki',
          startsAt: DateTime.utc(2026, 1, 1),
          endsAt: DateTime.utc(2026, 1, 2),
          finishedAt: DateTime.utc(2026, 1, 3),
          winners: [winner],
        ),
        ContestHistoryEntry(
          contestId: 'c1',
          name: 'Koszulki (duplicate)',
          startsAt: DateTime.utc(2026, 1, 1),
          endsAt: DateTime.utc(2026, 1, 2),
          finishedAt: DateTime.utc(2026, 1, 4),
          winners: [winner],
        ),
      ];
      final prizes = UserPrizeResolver.resolve(
        uid: 'u1',
        history: history,
        activeWin: null,
        activeContestId: null,
        activeContestName: '',
      );
      expect(prizes, hasLength(1));
      expect(prizes.single.contestId, 'c1');
      expect(prizes.single.contestName, 'Koszulki');
    });

    test('dedupes active win when already archived', () {
      final history = [
        ContestHistoryEntry(
          contestId: 'c2',
          name: 'Gadżety',
          startsAt: DateTime.utc(2026, 1, 1),
          endsAt: DateTime.utc(2026, 1, 2),
          finishedAt: DateTime.utc(2026, 1, 3),
          winners: [winner],
        ),
      ];
      final prizes = UserPrizeResolver.resolve(
        uid: 'u1',
        history: history,
        activeWin: winner,
        activeContestId: 'c2',
        activeContestName: 'Gadżety',
      );
      expect(prizes, hasLength(1));
    });
  });
}
