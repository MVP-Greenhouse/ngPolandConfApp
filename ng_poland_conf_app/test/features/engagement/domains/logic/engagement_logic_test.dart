import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/engagement_visibility.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/event_vote_toggle.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/latest_conference_resolver.dart';

void main() {
  group('LatestConferenceResolver', () {
    test('returns highest numeric confId', () {
      expect(
        LatestConferenceResolver.fromConfIds(['2018', '2026', '2025']),
        '2026',
      );
    });

    test('returns null when empty', () {
      expect(LatestConferenceResolver.fromConfIds([]), isNull);
    });
  });

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
      expect(
        config.forTrack(EventItemType.jsPoland).votingEnabled,
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

    test('shows top5 only on latest when enabled', () {
      expect(
        EngagementVisibility.showTop5(
          selectedConfId: '2026',
          latestConfId: '2026',
          top5Enabled: true,
        ),
        isTrue,
      );
      expect(
        EngagementVisibility.showTop5(
          selectedConfId: '2025',
          latestConfId: '2026',
          top5Enabled: true,
        ),
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
