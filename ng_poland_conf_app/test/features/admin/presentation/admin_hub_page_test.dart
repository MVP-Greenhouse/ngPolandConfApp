import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/admin_page.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/cubit/admin_cubit.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/logic/admin_hub_status.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_role.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/repositories/user_repository.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/usecases/ensure_user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/user_session_cubit.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/event_vote_counts.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/engagement_config_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/event_vote_repository.dart';
import 'package:ng_poland_conf_app/features/edition/datasources/repositories/edition_repository.dart';
import 'package:ng_poland_conf_app/features/edition/domains/repositories/edition_store.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conference.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conferences.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  final trackConfig = TrackEngagementConfig(
    votingEnabled: true,
    votingStartsAt: DateTime.utc(2026, 1, 1),
    votingEndsAt: DateTime.utc(2026, 1, 2),
    top5Enabled: true,
  );
  final config = EngagementConfig(
    tracks: {for (final type in EventItemType.values) type: trackConfig},
  );

  late _TestConferencesCubit conferences;
  late _TestUserSessionCubit session;
  late _FakeConfigRepository configRepo;
  late AdminCubit cubit;

  setUp(() async {
    conferences = _TestConferencesCubit()
      ..load(
        const Conference(confId: '2026', confName: 'NG Poland', listItems: []),
      );
    session = _TestUserSessionCubit()..signInAdmin();
    configRepo = _FakeConfigRepository(config);
    cubit = AdminCubit(
      configRepo,
      _FakeVoteRepository(),
      EditionRepository(_EmptyEditionRemote(), _EmptyEditionCache()),
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
  });

  testWidgets('shows hub with voting status', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AdminCubit>.value(
          value: cubit,
          child: const AdminPage(),
        ),
      ),
    );

    await tester.pump();

    expect(find.textContaining('Voting'), findsOneWidget);
    expect(find.text(AdminHubStatus.votingSubtitle(trackConfig)), findsWidgets);
    expect(find.textContaining('Top 5'), findsWidgets);
    expect(find.byType(AdminHubNavCard), findsOneWidget);
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
          uid: 'admin',
          displayName: 'Admin',
          email: 'admin@test.com',
          role: UserRole.admin,
        ),
      ),
    );
  }
}

class _FakeConfigRepository implements EngagementConfigRepository {
  _FakeConfigRepository(this._initial);

  final EngagementConfig _initial;
  final _controller = BehaviorSubject<EngagementConfig>();

  @override
  Stream<EngagementConfig> watchConfig(String confId) {
    _controller.add(_initial);
    return _controller.stream;
  }

  @override
  Future<void> saveTrackConfig({
    required String confId,
    required EventItemType track,
    required TrackEngagementConfig config,
  }) async {
    _controller.add(_initial.withTrack(track, config));
  }

  Future<void> dispose() => _controller.close();
}

class _FakeVoteRepository implements EventVoteRepository {
  @override
  Future<Map<String, EventVoteCounts>> loadVoteCounts(String confId) async =>
      const {};

  @override
  Future<void> setLike({
    required String confId,
    required String eventId,
    required String uid,
    required bool liked,
  }) async {}

  @override
  Stream<bool> watchMyLike({
    required String confId,
    required String eventId,
    required String uid,
  }) => Stream.value(false);
}

class _EmptyEditionRemote implements EditionRemote {
  @override
  Future<EditionFetch> agenda({String? etag}) async =>
      const EditionFetch.notModified();

  @override
  Future<EditionFetch> speakers({String? etag}) async =>
      const EditionFetch.notModified();
}

class _EmptyEditionCache implements EditionCache {
  @override
  Future<EditionCacheEntry?> read(String resource) async => null;

  @override
  Future<void> write(String resource, EditionCacheEntry entry) async {}
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
