import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/event_vote_ranking.dart';

void main() {
  test('sorts by likes desc then title', () {
    final ranked = EventVoteRanking.sort([
      const EventVoteRank(
        eventId: 'a',
        title: 'B talk',
        speakerName: 'A',
        trackType: 'ngPoland',
        likes: 10,
      ),
      const EventVoteRank(
        eventId: 'b',
        title: 'A talk',
        speakerName: 'B',
        trackType: 'ngPoland',
        likes: 10,
      ),
      const EventVoteRank(
        eventId: 'c',
        title: 'C talk',
        speakerName: 'C',
        trackType: 'ngPoland',
        likes: 20,
      ),
    ]);
    expect(ranked.map((e) => e.eventId).toList(), ['c', 'b', 'a']);
  });

  test('topForTrack returns at most five with likes', () {
    final input = [
      for (var i = 0; i < 8; i++)
        EventVoteRank(
          eventId: '$i',
          title: 'Talk $i',
          speakerName: 'S',
          trackType: 'jsPoland',
          likes: i + 1,
        ),
      const EventVoteRank(
        eventId: 'ng',
        title: 'NG',
        speakerName: 'S',
        trackType: 'ngPoland',
        likes: 100,
      ),
    ];
    final top = EventVoteRanking.topForTrack(
      input: input,
      trackType: 'jsPoland',
    );
    expect(top, hasLength(5));
    expect(top.first.likes, 8);
    expect(top.every((e) => e.trackType == 'jsPoland'), isTrue);
  });
}
