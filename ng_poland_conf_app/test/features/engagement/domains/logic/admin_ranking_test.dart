import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/speaker_vote_ranking.dart';

void main() {
  test('sorts by up desc then down asc', () {
    final ranked = SpeakerVoteRanking.sort([
      const SpeakerVoteRank(speakerId: 'a', name: 'A', up: 10, down: 5),
      const SpeakerVoteRank(speakerId: 'b', name: 'B', up: 10, down: 1),
      const SpeakerVoteRank(speakerId: 'c', name: 'C', up: 20, down: 0),
    ]);
    expect(ranked.map((e) => e.speakerId).toList(), ['c', 'b', 'a']);
  });
}
