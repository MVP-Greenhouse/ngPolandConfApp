import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_role.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/repositories/user_repository.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/usecases/ensure_user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/user_session_cubit.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_status.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/speaker_vote_counts.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/speaker_vote_value.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/engagement_config_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/speaker_vote_repository.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conference.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conferences.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/cubit/speaker_vote_cubit.dart';

void main() {
  late _TestConferencesCubit conferences;
  late _TestUserSessionCubit session;
  late _FakeConfigRepository config;
  late _FakeVoteRepository votes;
  SpeakerVoteCubit? cubit;

  final conference = Conference(
    confId: '2026',
    confName: 'NG Poland',
    listItems: const [],
  );

  setUp(() {
    conferences = _TestConferencesCubit()..load(conference);
    session = _TestUserSessionCubit();
    config = _FakeConfigRepository(_openVotingConfig);
    votes = _FakeVoteRepository();
  });

  tearDown(() async {
    await cubit?.close();
    await session.close();
    await conferences.close();
    await votes.dispose();
  });

  test('stays hidden when session is loading at create', () async {
    cubit = _buildCubit(
      votes: votes,
      config: config,
      session: session,
      conferences: conferences,
    );

    await pumpEventQueue();

    expect(cubit!.state, const SpeakerVoteState.hidden());
    expect(votes.watchMyVoteCalls, 0);
  });

  test(
    'does not keep needsLogin after auth starts; waits for first vote snapshot',
    () async {
      session.signOut();
      cubit = _buildCubit(
        votes: votes,
        config: config,
        session: session,
        conferences: conferences,
      );
      await pumpEventQueue();
      expect(cubit!.state, const SpeakerVoteState.needsLogin());

      session.signIn();
      await pumpEventQueue();

      expect(cubit!.state, isNot(const SpeakerVoteState.needsLogin()));
      expect(cubit!.state, const SpeakerVoteState.hidden());
      expect(votes.watchMyVoteCalls, 1);

      votes.voteController.add(SpeakerVoteValue.up);
      await pumpEventQueue();

      expect(cubit!.state, const SpeakerVoteState.ready(SpeakerVoteValue.up));
    },
  );

  test('holds hidden until the first watchMyVote snapshot', () async {
    session.signIn();
    cubit = _buildCubit(
      votes: votes,
      config: config,
      session: session,
      conferences: conferences,
    );

    await pumpEventQueue();

    expect(cubit!.state, const SpeakerVoteState.hidden());
    expect(votes.watchMyVoteCalls, 1);

    votes.voteController.add(SpeakerVoteValue.up);
    await pumpEventQueue();

    expect(cubit!.state, const SpeakerVoteState.ready(SpeakerVoteValue.up));
  });

  test('shows needsLogin immediately without watching votes', () async {
    session.signOut();
    cubit = _buildCubit(
      votes: votes,
      config: config,
      session: session,
      conferences: conferences,
    );

    await pumpEventQueue();

    expect(cubit!.state, const SpeakerVoteState.needsLogin());
    expect(votes.watchMyVoteCalls, 0);
  });

  test('ignores watchMyVote while saving and emits ready from the write', () async {
    session.signIn();
    cubit = _buildCubit(
      votes: votes,
      config: config,
      session: session,
      conferences: conferences,
    );
    await pumpEventQueue();
    votes.voteController.add(SpeakerVoteValue.up);
    await pumpEventQueue();
    expect(cubit!.state, const SpeakerVoteState.ready(SpeakerVoteValue.up));

    votes.pendingSetVote = Completer<void>();
    final tap = cubit!.tap(SpeakerVoteValue.down);
    await pumpEventQueue();

    expect(cubit!.state, const SpeakerVoteState.saving(SpeakerVoteValue.up));

    votes.voteController.add(null);
    await pumpEventQueue();

    expect(cubit!.state, const SpeakerVoteState.saving(SpeakerVoteValue.up));

    votes.pendingSetVote!.complete();
    await tap;

    expect(cubit!.state, const SpeakerVoteState.ready(SpeakerVoteValue.down));
  });

  test('keeps failure until the next tap even if watchMyVote emits', () async {
    session.signIn();
    cubit = _buildCubit(
      votes: votes,
      config: config,
      session: session,
      conferences: conferences,
    );
    await pumpEventQueue();
    votes.voteController.add(SpeakerVoteValue.up);
    await pumpEventQueue();
    expect(cubit!.state, const SpeakerVoteState.ready(SpeakerVoteValue.up));

    votes.setVoteError = Exception('write failed');
    await cubit!.tap(SpeakerVoteValue.down);

    expect(cubit!.state, const SpeakerVoteState.failure(SpeakerVoteValue.up));

    votes.voteController.add(SpeakerVoteValue.down);
    await pumpEventQueue();

    expect(cubit!.state, const SpeakerVoteState.failure(SpeakerVoteValue.up));
  });
}

SpeakerVoteCubit _buildCubit({
  required _FakeVoteRepository votes,
  required _FakeConfigRepository config,
  required _TestUserSessionCubit session,
  required _TestConferencesCubit conferences,
}) {
  return SpeakerVoteCubit(
    votes,
    config,
    session,
    conferences,
    'speaker-1',
  );
}

final _openVotingConfig = EngagementConfig(
  votingEnabled: true,
  votingStartsAt: DateTime.utc(2020),
  votingEndsAt: DateTime.utc(2099),
  contestEnabled: false,
  contestStartsAt: DateTime.utc(2020),
  contestEndsAt: DateTime.utc(2020),
  contestStatus: ContestStatus.idle,
);

class _TestConferencesCubit extends ConferencesCubit {
  void load(Conference conference) {
    selectedConference = conference;
    emit(
      ConferencesState.loaded(
        conferences: Conferences(list: [conference]),
        selectedConference: conference,
      ),
    );
  }
}

class _TestUserSessionCubit extends UserSessionCubit {
  _TestUserSessionCubit()
    : super(
        const EnsureUserProfile(_NoopUserRepository()),
        const _NoopUserRepository(),
        authStateChanges: const Stream.empty(),
      );

  void signIn() {
    emit(
      const UserSessionState.authenticated(
        UserProfile(
          uid: 'u1',
          displayName: 'Ada',
          email: 'ada@example.com',
          role: UserRole.user,
        ),
      ),
    );
  }

  void signOut() {
    emit(const UserSessionState.unauthenticated());
  }
}

class _NoopUserRepository implements UserRepository {
  const _NoopUserRepository();

  @override
  Future<UserProfile> ensureProfile({
    required String uid,
    required String displayName,
    required String email,
  }) {
    throw UnimplementedError();
  }

  @override
  Stream<UserProfile?> watchProfile(String uid) => const Stream.empty();
}

class _FakeConfigRepository implements EngagementConfigRepository {
  _FakeConfigRepository(this.config);

  final EngagementConfig config;

  @override
  Stream<EngagementConfig> watchConfig(String confId) => Stream.value(config);

  @override
  Future<void> saveConfig(String confId, EngagementConfig config) async {}
}

class _FakeVoteRepository implements SpeakerVoteRepository {
  final voteController = StreamController<SpeakerVoteValue?>.broadcast();
  Completer<void>? pendingSetVote;
  Object? setVoteError;
  var watchMyVoteCalls = 0;

  @override
  Stream<SpeakerVoteValue?> watchMyVote({
    required String confId,
    required String speakerId,
    required String uid,
  }) {
    watchMyVoteCalls++;
    return voteController.stream;
  }

  @override
  Future<void> setVote({
    required String confId,
    required String speakerId,
    required String uid,
    SpeakerVoteValue? value,
  }) async {
    if (setVoteError != null) throw setVoteError!;
    final pending = pendingSetVote;
    if (pending != null) await pending.future;
  }

  @override
  Stream<Map<String, SpeakerVoteValue>> watchAllVotes({
    required String confId,
    required String speakerId,
  }) => const Stream.empty();

  @override
  Future<Map<String, SpeakerVoteCounts>> loadVoteCounts(String confId) async =>
      {};

  Future<void> dispose() => voteController.close();
}
