import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/services/voting_window.dart';

void main() {
  test('flips when the voting window opens and closes', () {
    fakeAsync((async) {
      final start = DateTime.utc(2026, 11, 20, 9);
      final config = TrackEngagementConfig(
        votingEnabled: true,
        votingStartsAt: start,
        votingEndsAt: start.add(const Duration(hours: 1)),
        top5Enabled: false,
      );
      final clockStart = start.subtract(const Duration(minutes: 30));
      DateTime now() => clockStart.add(async.elapsed);
      final values = <bool>[];

      final subscription = watchVotingOpen(config, now: now).listen(values.add);
      async.flushMicrotasks();
      expect(values, [false]);

      async.elapse(const Duration(minutes: 30));
      expect(values, [false, true]);

      async.elapse(const Duration(hours: 1, seconds: 1));
      expect(values, [false, true, false]);

      subscription.cancel();
    });
  });
}
