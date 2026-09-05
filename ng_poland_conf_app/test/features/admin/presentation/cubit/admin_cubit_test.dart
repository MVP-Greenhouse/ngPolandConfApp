import 'dart:async';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/cubit/admin_cubit.dart';
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
import 'package:ng_poland_conf_app/features/engagement/domains/entities/speaker_vote_counts.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/speaker_vote_value.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/contest_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/engagement_config_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/speaker_vote_repository.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conference.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conferences.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/entities/speaker.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/repositories/speakers_repository.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/usecases/get_all_speakers_for_conference.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  late _TestConferencesCubit conferences;
  late _TestUserSessionCubit session;
  late _FakeConfigRepository config;
  late _FakeContestRepository contest;
  late _FakeVoteRepository votes;
  AdminCubit? cubit;

  final conference = Conference(
    confId: '2026',
    confName: 'NG Poland',
    listItems: const [],
  );

  setUp(() {
    conferences = _TestConferencesCubit()..load(conference);
    session = _TestUserSessionCubit()..signInAdmin();
    config = _FakeConfigRepository(_openContestConfig);
    contest = _FakeContestRepository();
    votes = _FakeVoteRepository();
  });

  tearDown(() async {
    await cubit?.close();
    await session.close();
    await conferences.close();
    await config.dispose();
    await contest.dispose();
  });

  test('seeds admin loading before watches emit', () {
    config = _FakeConfigRepository(_openContestConfig, delayWatch: true);
    contest = _FakeContestRepository(delayWatch: true);
    cubit = _buildCubit(
      config: config,
      contest: contest,
      votes: votes,
      session: session,
      conferences: conferences,
    );

    expect(cubit!.state.isAdmin, isTrue);
    expect(cubit!.state.loading, isTrue);
    expect(cubit!.state.latestConfId, '2026');
  });

  test('shows admin loading after session becomes admin', () async {
    session.signOut();
    config = _FakeConfigRepository(_openContestConfig, delayWatch: true);
    contest = _FakeContestRepository(delayWatch: true);
    cubit = _buildCubit(
      config: config,
      contest: contest,
      votes: votes,
      session: session,
      conferences: conferences,
    );
    await pumpEventQueue();
    expect(cubit!.state.isAdmin, isFalse);

    session.signInAdmin();
    await pumpEventQueue();

    expect(cubit!.state.isAdmin, isTrue);
    expect(cubit!.state.loading, isTrue);
    expect(cubit!.state.latestConfId, '2026');
  });

  test('surfaces watch errors as message', () async {
    cubit = _buildCubit(
      config: config,
      contest: contest,
      votes: votes,
      session: session,
      conferences: conferences,
    );
    await pumpEventQueue();
    expect(cubit!.state.config, isNotNull);

    config.config$.addError(Exception('network'));
    await pumpEventQueue();

    expect(cubit!.state.message, contains('network'));
    expect(cubit!.state.isAdmin, isTrue);
  });

  test('saveVoting after draw keeps drawing status', () async {
    contest.participants = const [
      ContestParticipant(uid: 'p1', displayName: 'Pat', email: 'p@x.com'),
    ];
    cubit = _buildCubit(
      config: config,
      contest: contest,
      votes: votes,
      session: session,
      conferences: conferences,
    );
    await pumpEventQueue();
    expect(cubit!.state.config?.contestStatus, ContestStatus.open);

    await cubit!.draw(count: 1, random: Random(1));
    await cubit!.saveVoting(
      enabled: true,
      start: DateTime.utc(2026, 1, 1),
      end: DateTime.utc(2026, 12, 31),
    );

    expect(config.lastSaved?.contestStatus, ContestStatus.drawing);
    expect(cubit!.state.config?.contestStatus, ContestStatus.drawing);
  });

  test('saveContest after finishDrawing keeps finished status', () async {
    contest.participants = const [
      ContestParticipant(uid: 'p1', displayName: 'Pat', email: 'p@x.com'),
    ];
    cubit = _buildCubit(
      config: config,
      contest: contest,
      votes: votes,
      session: session,
      conferences: conferences,
    );
    await pumpEventQueue();

    await cubit!.draw(count: 1, random: Random(1));
    await cubit!.finishDrawing();
    await cubit!.saveContest(
      enabled: true,
      start: DateTime.utc(2026, 1, 1),
      end: DateTime.utc(2026, 12, 31),
      name: 'Nagrody',
    );

    expect(config.lastSaved?.contestStatus, ContestStatus.finished);
    expect(cubit!.state.config?.contestStatus, ContestStatus.finished);
  });

  test('finishDrawing archives then marks finished', () async {
    config = _FakeConfigRepository(
      _openContestConfig.copyWith(
        contestId: 'contest-1',
        contestName: 'Nagrody',
      ),
    );
    contest.participants = const [
      ContestParticipant(uid: 'p1', displayName: 'Pat', email: 'p@x.com'),
    ];
    cubit = _buildCubit(
      config: config,
      contest: contest,
      votes: votes,
      session: session,
      conferences: conferences,
    );
    await pumpEventQueue();

    await cubit!.draw(count: 1, random: Random(1));
    contest.operations.clear();
    await cubit!.finishDrawing();

    expect(contest.operations, ['archive:contest-1', 'status:finished']);
    expect(contest.archived.single.name, 'Nagrody');
    expect(contest.archived.single.winners, hasLength(1));
    expect(cubit!.state.config?.contestStatus, ContestStatus.finished);
  });

  test('startNewContest carry keeps participants clears winners', () async {
    config = _FakeConfigRepository(
      _openContestConfig.copyWith(
        contestStatus: ContestStatus.finished,
        contestId: 'contest-1',
        contestName: 'Stary konkurs',
      ),
    );
    cubit = _buildCubit(
      config: config,
      contest: contest,
      votes: votes,
      session: session,
      conferences: conferences,
    );
    await pumpEventQueue();

    await cubit!.startNewContest(
      name: '  Nowy konkurs  ',
      carryParticipants: true,
    );
    await pumpEventQueue();

    expect(contest.operations, ['archive:contest-1', 'clearWinners']);
    expect(config.lastSaved?.contestName, 'Nowy konkurs');
    expect(config.lastSaved?.contestId, startsWith('c_'));
    expect(config.lastSaved?.contestStatus, ContestStatus.open);
    expect(config.lastSaved?.contestEnabled, isTrue);
    expect(cubit!.state.config?.contestStatus, ContestStatus.open);
    expect(cubit!.state.config?.contestName, 'Nowy konkurs');
  });

  test('startNewContest without carry clears both', () async {
    config = _FakeConfigRepository(
      _openContestConfig.copyWith(
        contestStatus: ContestStatus.finished,
        contestId: 'contest-1',
      ),
    );
    cubit = _buildCubit(
      config: config,
      contest: contest,
      votes: votes,
      session: session,
      conferences: conferences,
    );
    await pumpEventQueue();

    await cubit!.startNewContest(
      name: 'Nowy konkurs',
      carryParticipants: false,
    );

    expect(contest.operations, [
      'archive:contest-1',
      'clearWinners',
      'clearParticipants',
    ]);
  });

  test('startNewContest rejects when not finished', () async {
    cubit = _buildCubit(
      config: config,
      contest: contest,
      votes: votes,
      session: session,
      conferences: conferences,
    );
    await pumpEventQueue();

    await cubit!.startNewContest(
      name: 'Nowy konkurs',
      carryParticipants: false,
    );

    expect(cubit!.state.message, 'Konkurs musi być zakończony');
    expect(contest.operations, isEmpty);
    expect(config.lastSaved, isNull);
  });

  test('saveContest idle to open requires name', () async {
    config = _FakeConfigRepository(
      _openContestConfig.copyWith(
        contestEnabled: false,
        contestStatus: ContestStatus.idle,
      ),
    );
    cubit = _buildCubit(
      config: config,
      contest: contest,
      votes: votes,
      session: session,
      conferences: conferences,
    );
    await pumpEventQueue();

    await cubit!.saveContest(
      enabled: true,
      start: DateTime.utc(2026, 1, 1),
      end: DateTime.utc(2026, 12, 31),
      name: '   ',
    );

    expect(cubit!.state.message, 'Podaj nazwę konkursu');
    expect(config.lastSaved, isNull);

    cubit!.clearMessage();
    await cubit!.saveContest(
      enabled: true,
      start: DateTime.utc(2026, 1, 1),
      end: DateTime.utc(2026, 12, 31),
      name: '  Nagrody  ',
    );

    expect(config.lastSaved?.contestName, 'Nagrody');
    expect(config.lastSaved?.contestId, startsWith('c_'));
    expect(config.lastSaved?.contestStatus, ContestStatus.open);
  });

  test('watches contest history into state', () async {
    contest.history = [
      ContestHistoryEntry(
        contestId: 'contest-1',
        name: 'Poprzedni konkurs',
        startsAt: DateTime.utc(2026, 1, 1),
        endsAt: DateTime.utc(2026, 1, 2),
        finishedAt: DateTime.utc(2026, 1, 2),
        winners: const [],
      ),
    ];
    cubit = _buildCubit(
      config: config,
      contest: contest,
      votes: votes,
      session: session,
      conferences: conferences,
    );
    await pumpEventQueue();

    expect(cubit!.state.history.single.name, 'Poprzedni konkurs');
  });
}

AdminCubit _buildCubit({
  required _FakeConfigRepository config,
  required _FakeContestRepository contest,
  required _FakeVoteRepository votes,
  required _TestUserSessionCubit session,
  required _TestConferencesCubit conferences,
}) {
  return AdminCubit(
    config,
    votes,
    contest,
    GetAllSpeakersForConference(_EmptySpeakersRepository()),
    session,
    conferences,
  );
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

  void signInAdmin() {
    emit(
      const UserSessionState.authenticated(
        UserProfile(
          uid: 'a1',
          displayName: 'Admin',
          email: 'admin@example.com',
          role: UserRole.admin,
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

class _EmptySpeakersRepository implements SpeakersRepository {
  @override
  Future<List<Speaker>> getAllSpeakers(Params params) async => const [];
}

class _FakeConfigRepository implements EngagementConfigRepository {
  _FakeConfigRepository(EngagementConfig config, {this.delayWatch = false})
    : config$ = delayWatch
          ? BehaviorSubject<EngagementConfig>()
          : BehaviorSubject<EngagementConfig>.seeded(config);

  final bool delayWatch;
  final BehaviorSubject<EngagementConfig> config$;
  EngagementConfig? lastSaved;

  @override
  Stream<EngagementConfig> watchConfig(String confId) => config$.stream;

  @override
  Future<void> saveConfig(String confId, EngagementConfig config) async {
    lastSaved = config;
    config$.add(config);
  }

  Future<void> dispose() => config$.close();
}

class _FakeContestRepository implements ContestRepository {
  _FakeContestRepository({this.delayWatch = false});

  final bool delayWatch;
  List<ContestParticipant> participants = const [];
  List<ContestHistoryEntry> history = const [];
  final winners$ = BehaviorSubject<List<ContestWinner>>.seeded(const []);
  final List<ContestHistoryEntry> archived = [];
  final List<String> operations = [];
  ContestStatus? lastStatus;

  @override
  Stream<ContestParticipant?> watchMyParticipation({
    required String confId,
    required String uid,
  }) => Stream.value(null);

  @override
  Future<void> join({
    required String confId,
    required String uid,
    required String displayName,
    required String email,
  }) async {}

  @override
  Stream<List<ContestParticipant>> watchParticipants(String confId) {
    if (delayWatch) return const Stream.empty();
    return Stream.value(participants);
  }

  @override
  Stream<ContestWinner?> watchMyWin({
    required String confId,
    required String uid,
  }) => Stream.value(null);

  @override
  Stream<List<ContestWinner>> watchWinners(String confId) {
    if (delayWatch) return const Stream.empty();
    return winners$.stream;
  }

  @override
  Future<void> saveWinners({
    required String confId,
    required List<ContestWinner> winners,
  }) async {
    winners$.add([...winners$.value, ...winners]);
  }

  @override
  Future<void> updateContestStatus({
    required String confId,
    required ContestStatus status,
  }) async {
    lastStatus = status;
    operations.add('status:${status.name}');
  }

  @override
  Stream<List<ContestHistoryEntry>> watchHistory(String confId) =>
      Stream.value(history);

  @override
  Future<void> archiveContestIfAbsent({
    required String confId,
    required ContestHistoryEntry entry,
  }) async {
    archived.add(entry);
    operations.add('archive:${entry.contestId}');
  }

  @override
  Future<void> clearWinners(String confId) async {
    operations.add('clearWinners');
  }

  @override
  Future<void> clearParticipants(String confId) async {
    operations.add('clearParticipants');
  }

  Future<void> dispose() => winners$.close();
}

class _FakeVoteRepository implements SpeakerVoteRepository {
  @override
  Stream<SpeakerVoteValue?> watchMyVote({
    required String confId,
    required String speakerId,
    required String uid,
  }) => Stream.value(null);

  @override
  Future<void> setVote({
    required String confId,
    required String speakerId,
    required String uid,
    SpeakerVoteValue? value,
  }) async {}

  @override
  Stream<Map<String, SpeakerVoteValue>> watchAllVotes({
    required String confId,
    required String speakerId,
  }) => const Stream.empty();

  @override
  Future<Map<String, SpeakerVoteCounts>> loadVoteCounts(String confId) async =>
      {};
}
