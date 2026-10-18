import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_session.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/conference.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/entities/votable_event.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/exceptions/engagement_exception.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/usecases/cast_event_vote.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/usecases/watch_event_vote.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/usecases/watch_track_engagement.dart';
import 'package:ng_poland_conf_app/features/event/presentation/cubit/event_vote_cubit.dart';

import '../../../../helpers/fakes.dart';

void main() {
  late FakeUserSessionRepository sessions;
  late FakeConferenceRepository conferences;
  late FakeEngagementConfigRepository configs;
  late FakeEventVoteRepository votes;
  late FakeVotableEventRepository votable;
  late EventVoteCubit cubit;

  setUp(() {
    sessions = FakeUserSessionRepository(
      const UserSession.signedIn(userProfile),
    );
    conferences = FakeConferenceRepository(
      const Conference(confId: '2026', confName: 'NG', listItems: []),
    );
    configs = FakeEngagementConfigRepository(_openConfig());
    votes = FakeEventVoteRepository();
    votable = FakeVotableEventRepository();
  });

  tearDown(() async {
    await cubit.close();
    await sessions.dispose();
    await conferences.dispose();
    await configs.dispose();
    await votes.dispose();
  });

  EventVoteCubit open() => EventVoteCubit(
    WatchEventVote(
      WatchTrackEngagement(conferences, configs),
      sessions,
      votable,
      votes,
    ),
    CastEventVote(sessions, conferences, votes),
    silentLogger,
    '2',
    EventItemType.ngPoland,
  );

  void endedTalk() => votable.events = {
    '2': VotableEvent(
      eventId: '2',
      endsAt: DateTime.utc(2000),
      track: EventItemType.ngPoland,
    ),
  };

  test('hides the like button when the catalog has no document', () async {
    cubit = open();
    await pumpEventQueue();

    expect(cubit.state, isA<VoteHidden>());
  });

  test('hides the like button before the talk ends', () async {
    votable.events = {
      '2': VotableEvent(
        eventId: '2',
        endsAt: DateTime.now().toUtc().add(const Duration(days: 1)),
        track: EventItemType.ngPoland,
      ),
    };
    cubit = open();
    await pumpEventQueue();

    expect(cubit.state.showButton, isFalse);
  });

  test('shows the like button after the talk has ended', () async {
    endedTalk();
    cubit = open();
    await pumpUntil(() => cubit.state.showButton);

    expect(cubit.state, const EventVoteState.ready(false));
  });

  test('asks signed-out users to log in', () async {
    endedTalk();
    sessions.emit(const UserSession.signedOut());
    cubit = open();
    await pumpUntil(() => cubit.state.showButton);

    expect(cubit.state, isA<VoteNeedsLogin>());
    expect(cubit.requiresLogin, isTrue);
  });

  test('toggleLike saves the vote', () async {
    endedTalk();
    cubit = open();
    await pumpUntil(() => cubit.state.showButton);

    await cubit.toggleLike();

    expect(votes.setLikeCalls, [(eventId: '2', liked: true)]);
    expect(cubit.state.liked, isTrue);
  });

  test('toggleLike keeps the previous vote when saving fails', () async {
    endedTalk();
    votes.setLikeError = const EngagementException();
    cubit = open();
    await pumpUntil(() => cubit.state.showButton);

    await cubit.toggleLike();

    expect(cubit.state, const EventVoteState.failure(false));
  });
}

EngagementConfig _openConfig() {
  final track = TrackEngagementConfig(
    votingEnabled: true,
    votingStartsAt: DateTime.utc(2020),
    votingEndsAt: DateTime.utc(2999),
    top5Enabled: false,
  );
  return EngagementConfig(
    tracks: {for (final type in EventItemType.values) type: track},
  );
}
