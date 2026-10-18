import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/services/event_vote_toggle.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/services/votable_event_catalog.dart';

void main() {
  group('TrackEngagementConfig windows', () {
    final now = DateTime.utc(2026, 11, 20, 12);

    test('voting open only when enabled and now inside window', () {
      final config = TrackEngagementConfig(
        votingEnabled: true,
        votingStartsAt: DateTime.utc(2026, 11, 20, 9),
        votingEndsAt: DateTime.utc(2026, 11, 21, 18),
        top5Enabled: false,
      );
      expect(config.isVotingOpen(now), isTrue);
      expect(config.isVotingOpen(DateTime.utc(2026, 11, 19)), isFalse);
    });

    test('forTrack returns missing when track absent', () {
      const config = EngagementConfig(tracks: {});
      expect(config.forTrack(EventItemType.jsPoland).votingEnabled, isFalse);
    });
  });

  group('TrackEngagementConfig.nextWindowChangeAfter', () {
    final config = TrackEngagementConfig(
      votingEnabled: true,
      votingStartsAt: DateTime.utc(2026, 11, 20, 9),
      votingEndsAt: DateTime.utc(2026, 11, 21, 18),
      top5Enabled: false,
    );

    test('is the start before the window opens', () {
      expect(
        config.nextWindowChangeAfter(DateTime.utc(2026, 11, 19)),
        config.votingStartsAt,
      );
    });

    test('is just after the end while voting is open', () {
      final next = config.nextWindowChangeAfter(DateTime.utc(2026, 11, 20, 12));
      expect(next, isNotNull);
      expect(config.isVotingOpen(next!), isFalse);
      expect(next.isAfter(config.votingEndsAt), isTrue);
    });

    test('is null once the window closed or voting is disabled', () {
      expect(config.nextWindowChangeAfter(DateTime.utc(2026, 12)), isNull);
      expect(
        config
            .copyWith(votingEnabled: false)
            .nextWindowChangeAfter(DateTime.utc(2026, 11, 19)),
        isNull,
      );
    });
  });

  group('canToggleVote', () {
    final endsAt = DateTime.utc(2026, 11, 20, 10);

    test('allows withdrawing a vote at any time', () {
      expect(
        canToggleVote(votedByMe: true, endsAt: endsAt, now: DateTime.utc(2026)),
        isTrue,
      );
    });

    test('allows a new vote only after the talk ended', () {
      expect(
        canToggleVote(
          votedByMe: false,
          endsAt: endsAt,
          now: endsAt.subtract(const Duration(minutes: 1)),
        ),
        isFalse,
      );
      expect(
        canToggleVote(votedByMe: false, endsAt: endsAt, now: endsAt),
        isTrue,
      );
      expect(
        canToggleVote(votedByMe: false, endsAt: null, now: endsAt),
        isFalse,
      );
    });
  });

  group('EventVoteToggle', () {
    test('toggles like state', () {
      expect(EventVoteToggle.apply(currentlyLiked: false), isTrue);
      expect(EventVoteToggle.apply(currentlyLiked: true), isFalse);
    });
  });
}
