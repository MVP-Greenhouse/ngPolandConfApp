import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/admin_page.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/cubit/admin_cubit.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/logic/admin_hub_status.dart';
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
  final config = EngagementConfig(
    votingEnabled: true,
    votingStartsAt: DateTime.utc(2026, 1, 1),
    votingEndsAt: DateTime.utc(2026, 1, 2),
    contestEnabled: true,
    contestStartsAt: DateTime.utc(2026, 1, 1),
    contestEndsAt: DateTime.utc(2026, 1, 2),
    contestStatus: ContestStatus.open,
  );

  const participants = [
    ContestParticipant(uid: 'u1', displayName: 'Ada', email: 'a@x.com'),
    ContestParticipant(uid: 'u2', displayName: 'Bob', email: 'b@x.com'),
    ContestParticipant(uid: 'u3', displayName: 'Cal', email: 'c@x.com'),
  ];

  late _TestConferencesCubit conferences;
  late _TestUserSessionCubit session;
  late _FakeConfigRepository configRepo;
  late _FakeContestRepository contestRepo;
  late AdminCubit cubit;

  setUp(() async {
    conferences = _TestConferencesCubit()
      ..load(
        const Conference(
          confId: '2026',
          confName: 'NG Poland',
          listItems: [],
        ),
      );
    session = _TestUserSessionCubit()..signInAdmin();
    configRepo = _FakeConfigRepository(config);
    contestRepo = _FakeContestRepository()..participants = participants;
    cubit = AdminCubit(
      configRepo,
      _FakeVoteRepository(),
      contestRepo,
      GetAllSpeakersForConference(_EmptySpeakersRepository()),
      session,
      conferences,
    );
    await pumpEventQueue();
  });

  tearDown(() async {
    await cubit.close();
    await session.close();
    await conferences.close();
    await configRepo.dispose();
    await contestRepo.dispose();
  });

  testWidgets('shows hub destinations with status subtitles', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AdminCubit>.value(
          value: cubit,
          child: const AdminPage(),
        ),
      ),
    );

    await tester.pump();

    expect(find.text('Głosowanie'), findsOneWidget);
    expect(find.text('Konkurs'), findsOneWidget);
    expect(find.text(AdminHubStatus.votingSubtitle(config)), findsWidgets);
    expect(
      find.text(AdminHubStatus.contestStatusLabel(config.contestStatus)),
      findsOneWidget,
    );
    expect(
      find.text(AdminHubStatus.participantChipLabel(participants.length)),
      findsOneWidget,
    );
    expect(find.byType(ExpansionTile), findsNothing);
    expect(find.byType(AdminHubNavCard), findsNWidgets(2));
  });
}

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
  _FakeConfigRepository(EngagementConfig config)
    : config$ = BehaviorSubject<EngagementConfig>.seeded(config);

  final BehaviorSubject<EngagementConfig> config$;

  @override
  Stream<EngagementConfig> watchConfig(String confId) => config$.stream;

  @override
  Future<void> saveConfig(String confId, EngagementConfig config) async {
    config$.add(config);
  }

  Future<void> dispose() => config$.close();
}

class _FakeContestRepository implements ContestRepository {
  List<ContestParticipant> participants = const [];

  final winners$ = BehaviorSubject<List<ContestWinner>>.seeded(const []);

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
  Stream<List<ContestParticipant>> watchParticipants(String confId) =>
      Stream.value(participants);

  @override
  Stream<ContestWinner?> watchMyWin({
    required String confId,
    required String uid,
  }) => Stream.value(null);

  @override
  Stream<List<ContestWinner>> watchWinners(String confId) => winners$.stream;

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
