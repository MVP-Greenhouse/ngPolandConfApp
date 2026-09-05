import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_status.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/speaker_vote_value.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/contest_draw.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/contest_home_view.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/engagement_visibility.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/latest_conference_resolver.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/speaker_vote_toggle.dart';

void main() {
  group('LatestConferenceResolver', () {
    test('returns highest numeric confId', () {
      expect(
        LatestConferenceResolver.fromConfIds(['2018', '2026', '2025']),
        '2026',
      );
    });

    test('ignores non-numeric ids', () {
      expect(
        LatestConferenceResolver.fromConfIds(['ng', '2024']),
        '2024',
      );
    });

    test('returns null when empty', () {
      expect(LatestConferenceResolver.fromConfIds([]), isNull);
    });
  });

  group('EngagementConfig windows', () {
    final now = DateTime.utc(2026, 11, 20, 12);

    test('voting open only when enabled and now inside window', () {
      final config = EngagementConfig(
        votingEnabled: true,
        votingStartsAt: DateTime.utc(2026, 11, 20, 9),
        votingEndsAt: DateTime.utc(2026, 11, 21, 18),
        contestEnabled: false,
        contestStartsAt: now,
        contestEndsAt: now,
        contestStatus: ContestStatus.idle,
      );
      expect(config.isVotingOpen(now), isTrue);
      expect(config.isVotingOpen(DateTime.utc(2026, 11, 19)), isFalse);
    });

    test('contest join open when enabled, in window, status idle or open', () {
      final config = EngagementConfig(
        votingEnabled: false,
        votingStartsAt: now,
        votingEndsAt: now,
        contestEnabled: true,
        contestStartsAt: DateTime.utc(2026, 11, 20, 10),
        contestEndsAt: DateTime.utc(2026, 11, 20, 16),
        contestStatus: ContestStatus.open,
      );
      expect(config.isContestJoinOpen(now), isTrue);
      expect(
        config.copyWith(contestStatus: ContestStatus.drawing).isContestJoinOpen(now),
        isFalse,
      );
    });
  });

  group('EngagementVisibility', () {
    test('hides voting when selected conference is not latest', () {
      expect(
        EngagementVisibility.showVoting(
          selectedConfId: '2025',
          latestConfId: '2026',
          votingOpen: true,
        ),
        isFalse,
      );
    });
  });

  group('ContestHomeViewResolver', () {
    final openConfig = EngagementConfig(
      votingEnabled: false,
      votingStartsAt: DateTime.utc(2026, 1, 1),
      votingEndsAt: DateTime.utc(2026, 1, 1),
      contestEnabled: true,
      contestStartsAt: DateTime.utc(2026, 11, 20, 10),
      contestEndsAt: DateTime.utc(2026, 11, 20, 16),
      contestStatus: ContestStatus.open,
    );
    final now = DateTime.utc(2026, 11, 20, 12);

    test('join when latest, open, not participating', () {
      expect(
        ContestHomeViewResolver.resolve(
          isLatestConference: true,
          config: openConfig,
          now: now,
          isParticipant: false,
          isWinner: false,
        ),
        ContestHomeView.join,
      );
    });

    test('joined when participating and still open', () {
      expect(
        ContestHomeViewResolver.resolve(
          isLatestConference: true,
          config: openConfig,
          now: now,
          isParticipant: true,
          isWinner: false,
        ),
        ContestHomeView.joined,
      );
    });

    test('winner as soon as drawn, even before finished', () {
      expect(
        ContestHomeViewResolver.resolve(
          isLatestConference: true,
          config: openConfig.copyWith(contestStatus: ContestStatus.drawing),
          now: now,
          isParticipant: true,
          isWinner: true,
        ),
        ContestHomeView.winner,
      );
    });

    test('loser only when finished, participant, not winner', () {
      expect(
        ContestHomeViewResolver.resolve(
          isLatestConference: true,
          config: openConfig.copyWith(contestStatus: ContestStatus.finished),
          now: now,
          isParticipant: true,
          isWinner: false,
        ),
        ContestHomeView.loser,
      );
    });

    test('non-participants see hidden after finish', () {
      expect(
        ContestHomeViewResolver.resolve(
          isLatestConference: true,
          config: openConfig.copyWith(contestStatus: ContestStatus.finished),
          now: now,
          isParticipant: false,
          isWinner: false,
        ),
        ContestHomeView.hidden,
      );
    });

    test('hidden on historical conference', () {
      expect(
        ContestHomeViewResolver.resolve(
          isLatestConference: false,
          config: openConfig,
          now: now,
          isParticipant: false,
          isWinner: false,
        ),
        ContestHomeView.hidden,
      );
    });

    test('historical winner with open contest sees join, not winner', () {
      expect(
        ContestHomeViewResolver.resolve(
          isLatestConference: true,
          config: openConfig,
          now: now,
          isParticipant: false,
          isWinner: false, // active winners only
        ),
        ContestHomeView.join,
      );
    });

    test('active winner still winner even if they also have history', () {
      expect(
        ContestHomeViewResolver.resolve(
          isLatestConference: true,
          config: openConfig.copyWith(contestStatus: ContestStatus.drawing),
          now: now,
          isParticipant: true,
          isWinner: true,
        ),
        ContestHomeView.winner,
      );
    });
  });

  group('SpeakerVoteToggle', () {
    test('same thumb clears vote', () {
      expect(
        SpeakerVoteToggle.apply(
          current: SpeakerVoteValue.up,
          tapped: SpeakerVoteValue.up,
        ),
        isNull,
      );
    });

    test('other thumb switches vote', () {
      expect(
        SpeakerVoteToggle.apply(
          current: SpeakerVoteValue.up,
          tapped: SpeakerVoteValue.down,
        ),
        SpeakerVoteValue.down,
      );
    });

    test('no vote then up sets up', () {
      expect(
        SpeakerVoteToggle.apply(current: null, tapped: SpeakerVoteValue.up),
        SpeakerVoteValue.up,
      );
    });
  });

  group('ContestDraw', () {
    test('excludes existing winners and caps to pool size', () {
      final picked = ContestDraw.pick(
        participantIds: ['a', 'b', 'c'],
        winnerIds: {'b'},
        count: 5,
        random: Random(1),
      );
      expect(picked.length, 2);
      expect(picked.toSet().intersection({'b'}), isEmpty);
      expect(picked.toSet().intersection({'a', 'c'}).length, 2);
    });

    test('empty pool returns empty and does not throw', () {
      expect(
        ContestDraw.pick(
          participantIds: ['a'],
          winnerIds: {'a'},
          count: 1,
          random: Random(1),
        ),
        isEmpty,
      );
    });
  });
}
