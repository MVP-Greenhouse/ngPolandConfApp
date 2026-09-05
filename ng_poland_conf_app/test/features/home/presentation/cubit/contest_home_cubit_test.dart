import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_role.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/repositories/user_repository.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/usecases/ensure_user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/user_session_cubit.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_history_entry.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_participant.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_status.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_winner.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/contest_home_view.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/contest_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/engagement_config_repository.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conference.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conferences.dart';
import 'package:ng_poland_conf_app/features/home/presentation/cubit/contest_home_cubit.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  late _TestConferencesCubit conferences;
  late _TestUserSessionCubit session;
  late _FakeConfigRepository config;
  late _FakeContestRepository contest;
  ContestHomeCubit? cubit;

  final conference = Conference(
    confId: '2026',
    confName: 'NG Poland',
    listItems: const [],
  );

  setUp(() {
    conferences = _TestConferencesCubit()..load(conference);
    session = _TestUserSessionCubit();
    config = _FakeConfigRepository(_openContestConfig);
    contest = _FakeContestRepository();
  });

  tearDown(() async {
    await cubit?.close();
    await session.close();
    await conferences.close();
    await contest.dispose();
  });

  test('loading session does not flash winner or loser', () async {
    cubit = _buildCubit(
      contest: contest,
      config: config,
      session: session,
      conferences: conferences,
    );
    await pumpEventQueue();

    expect(cubit!.state.view, ContestHomeView.join);
    expect(contest.watchMyParticipationCalls, 0);
    expect(contest.watchMyWinCalls, 0);
  });

  test('unauthenticated join view does not write on join()', () async {
    session.signOut();
    cubit = _buildCubit(
      contest: contest,
      config: config,
      session: session,
      conferences: conferences,
    );
    await pumpEventQueue();
    expect(cubit!.state.view, ContestHomeView.join);
    expect(cubit!.requiresLogin(), isTrue);

    await cubit!.join();

    expect(contest.joinCalls, 0);
  });

  test('authenticated tap joins with profile and is never automatic', () async {
    session.signOut();
    cubit = _buildCubit(
      contest: contest,
      config: config,
      session: session,
      conferences: conferences,
    );
    await pumpEventQueue();

    session.signIn();
    await pumpEventQueue();

    expect(contest.joinCalls, 0);
    expect(cubit!.state.view, ContestHomeView.join);
    expect(cubit!.requiresLogin(), isFalse);

    await cubit!.join();

    expect(contest.joinCalls, 1);
    expect(contest.lastJoin, (
      confId: '2026',
      uid: 'u1',
      displayName: 'Ada',
      email: 'ada@example.com',
    ));
  });

  test('join failure sets joinFailed', () async {
    session.signIn();
    contest.joinError = Exception('denied');
    cubit = _buildCubit(
      contest: contest,
      config: config,
      session: session,
      conferences: conferences,
    );
    await pumpEventQueue();

    await cubit!.join();

    expect(cubit!.state.joinFailed, isTrue);
  });

  test('stream error keeps last good home state', () async {
    session.signOut();
    final config$ = BehaviorSubject<EngagementConfig>.seeded(
      _openContestConfig,
    );
    addTearDown(config$.close);
    cubit = _buildCubit(
      contest: contest,
      config: _StreamConfigRepository(config$),
      session: session,
      conferences: conferences,
    );
    await pumpEventQueue();
    expect(cubit!.state.view, ContestHomeView.join);

    config$.addError(Exception('network'));
    await pumpEventQueue();

    expect(cubit!.state.view, ContestHomeView.join);
  });

  test('winner view when watchMyWin emits', () async {
    session.signIn();
    contest.participant = const ContestParticipant(
      uid: 'u1',
      displayName: 'Ada',
      email: 'ada@example.com',
    );
    contest.winner = const ContestWinner(
      uid: 'u1',
      displayName: 'Ada',
      email: 'ada@example.com',
      order: 0,
    );
    cubit = _buildCubit(
      contest: contest,
      config: config,
      session: session,
      conferences: conferences,
    );
    await pumpEventQueue();

    expect(cubit!.state.view, ContestHomeView.winner);
  });
}

ContestHomeCubit _buildCubit({
  required _FakeContestRepository contest,
  required EngagementConfigRepository config,
  required _TestUserSessionCubit session,
  required _TestConferencesCubit conferences,
}) {
  return ContestHomeCubit(contest, config, session, conferences);
}

final _openContestConfig = EngagementConfig(
  votingEnabled: false,
  votingStartsAt: DateTime.utc(2020),
  votingEndsAt: DateTime.utc(2020),
  contestEnabled: true,
  contestStartsAt: DateTime.utc(2020),
  contestEndsAt: DateTime.utc(2099),
  contestStatus: ContestStatus.open,
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

class _StreamConfigRepository implements EngagementConfigRepository {
  _StreamConfigRepository(this._stream);

  final Stream<EngagementConfig> _stream;

  @override
  Stream<EngagementConfig> watchConfig(String confId) => _stream;

  @override
  Future<void> saveConfig(String confId, EngagementConfig config) async {}
}

class _FakeContestRepository implements ContestRepository {
  ContestParticipant? participant;
  ContestWinner? winner;
  Object? joinError;
  var joinCalls = 0;
  var watchMyParticipationCalls = 0;
  var watchMyWinCalls = 0;
  ({String confId, String uid, String displayName, String email})? lastJoin;

  @override
  Stream<ContestParticipant?> watchMyParticipation({
    required String confId,
    required String uid,
  }) {
    watchMyParticipationCalls++;
    return Stream.value(participant);
  }

  @override
  Future<void> join({
    required String confId,
    required String uid,
    required String displayName,
    required String email,
  }) async {
    joinCalls++;
    lastJoin = (
      confId: confId,
      uid: uid,
      displayName: displayName,
      email: email,
    );
    if (joinError != null) throw joinError!;
  }

  @override
  Stream<List<ContestParticipant>> watchParticipants(String confId) =>
      const Stream.empty();

  @override
  Stream<ContestWinner?> watchMyWin({
    required String confId,
    required String uid,
  }) {
    watchMyWinCalls++;
    return Stream.value(winner);
  }

  @override
  Stream<List<ContestWinner>> watchWinners(String confId) =>
      const Stream.empty();

  @override
  Future<void> saveWinners({
    required String confId,
    required List<ContestWinner> winners,
  }) async {}

  @override
  Future<void> updateContestStatus({
    required String confId,
    required ContestStatus status,
  }) async {}

  @override
  Stream<List<ContestHistoryEntry>> watchHistory(String confId) =>
      Stream.value(const []);

  @override
  Future<void> archiveContestIfAbsent({
    required String confId,
    required ContestHistoryEntry entry,
  }) async {}

  @override
  Future<void> clearWinners(String confId) async {}

  @override
  Future<void> clearParticipants(String confId) async {}

  Future<void> dispose() async {}
}
