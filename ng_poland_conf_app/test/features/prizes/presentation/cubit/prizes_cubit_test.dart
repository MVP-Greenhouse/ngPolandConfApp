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
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/contest_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/engagement_config_repository.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conference.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conferences.dart';
import 'package:ng_poland_conf_app/features/prizes/presentation/cubit/prizes_cubit.dart';

void main() {
  late _TestConferencesCubit conferences;
  late _TestUserSessionCubit session;
  PrizesCubit? cubit;

  setUp(() {
    conferences = _TestConferencesCubit()..load();
    session = _TestUserSessionCubit()..signIn();
  });

  tearDown(() async {
    await cubit?.close();
    await session.close();
    await conferences.close();
  });

  test('resolves archived and active prizes for signed-in user', () async {
    cubit = PrizesCubit(
      _FakeContestRepository(),
      const _FakeConfigRepository(),
      session,
      conferences,
    );

    await pumpEventQueue();

    expect(cubit!.state.loading, isFalse);
    expect(cubit!.state.hasPrizes, isTrue);
    expect(cubit!.state.prizes.map((prize) => prize.contestName), [
      'Aktualny konkurs',
      'Poprzedni konkurs',
    ]);
  });

  test('active win with empty contestId yields no prizes', () async {
    cubit = PrizesCubit(
      _ActiveWinOnlyContestRepository(),
      const _EmptyContestIdConfigRepository(),
      session,
      conferences,
    );

    await pumpEventQueue();

    expect(cubit!.state.loading, isFalse);
    expect(cubit!.state.hasPrizes, isFalse);
    expect(cubit!.state.prizes, isEmpty);
  });

  test('clears prizes after sign-out', () async {
    cubit = PrizesCubit(
      _FakeContestRepository(),
      const _FakeConfigRepository(),
      session,
      conferences,
    );
    await pumpEventQueue();

    session.signOut();
    await pumpEventQueue();

    expect(cubit!.state, const PrizesState(loading: false));
  });
}

class _TestConferencesCubit extends ConferencesCubit {
  void load() {
    final conference = Conference(
      confId: '2026',
      confName: 'NG Poland',
      listItems: const [],
    );
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

  void signOut() => emit(const UserSessionState.unauthenticated());
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
  const _FakeConfigRepository();

  @override
  Stream<EngagementConfig> watchConfig(String confId) => Stream.value(
    EngagementConfig.missing.copyWith(
      contestId: 'active',
      contestName: 'Aktualny konkurs',
    ),
  );

  @override
  Future<void> saveConfig(String confId, EngagementConfig config) async {}
}

class _EmptyContestIdConfigRepository implements EngagementConfigRepository {
  const _EmptyContestIdConfigRepository();

  @override
  Stream<EngagementConfig> watchConfig(String confId) =>
      Stream.value(EngagementConfig.missing);

  @override
  Future<void> saveConfig(String confId, EngagementConfig config) async {}
}

class _FakeContestRepository implements ContestRepository {
  static const winner = ContestWinner(
    uid: 'u1',
    displayName: 'Ada',
    email: 'ada@example.com',
    order: 1,
  );

  @override
  Stream<ContestWinner?> watchMyWin({
    required String confId,
    required String uid,
  }) => Stream.value(winner);

  @override
  Stream<List<ContestHistoryEntry>> watchHistory(String confId) =>
      Stream.value([
        ContestHistoryEntry(
          contestId: 'archived',
          name: 'Poprzedni konkurs',
          startsAt: DateTime.utc(2026, 1, 1),
          endsAt: DateTime.utc(2026, 1, 2),
          finishedAt: DateTime.utc(2026, 1, 2),
          winners: const [winner],
        ),
      ]);

  @override
  Stream<ContestParticipant?> watchMyParticipation({
    required String confId,
    required String uid,
  }) => const Stream.empty();

  @override
  Future<void> join({
    required String confId,
    required String uid,
    required String displayName,
    required String email,
  }) async {}

  @override
  Stream<List<ContestParticipant>> watchParticipants(String confId) =>
      const Stream.empty();

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
  Future<void> archiveContestIfAbsent({
    required String confId,
    required ContestHistoryEntry entry,
  }) async {}

  @override
  Future<void> clearWinners(String confId) async {}

  @override
  Future<void> clearParticipants(String confId) async {}
}

class _ActiveWinOnlyContestRepository extends _FakeContestRepository {
  @override
  Stream<List<ContestHistoryEntry>> watchHistory(String confId) =>
      Stream.value(const []);
}
