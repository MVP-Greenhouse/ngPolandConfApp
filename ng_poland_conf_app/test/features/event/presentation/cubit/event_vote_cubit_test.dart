import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_role.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/repositories/user_repository.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/usecases/ensure_user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/user_session_cubit.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/event_vote_counts.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/votable_event.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/engagement_config_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/event_vote_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/votable_event_repository.dart';
import 'package:ng_poland_conf_app/features/event/presentation/cubit/event_vote_cubit.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conference.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conferences.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  late _FakeVotableEvents votable;
  late _TestUserSessionCubit session;
  late _TestConferencesCubit conferences;
  late EventVoteCubit cubit;

  setUp(() {
    votable = _FakeVotableEvents();
    session = _TestUserSessionCubit()..signIn();
    conferences = _TestConferencesCubit()
      ..load(const Conference(confId: '2026', confName: 'NG', listItems: []));
  });

  tearDown(() async {
    await cubit.close();
    await session.close();
    await conferences.close();
    await votable.dispose();
  });

  EventVoteCubit open() {
    return EventVoteCubit(
      _FakeVoteRepository(),
      votable,
      _FakeConfigRepository(_openConfig()),
      session,
      conferences,
      '2',
      EventItemType.ngPoland.name,
    );
  }

  test('hides the like button when the catalog has no document', () async {
    cubit = open();
    await Future<void>.delayed(const Duration(milliseconds: 40));
    expect(cubit.state.showButton, isFalse);
  });

  test('hides the like button before the talk ends', () async {
    votable.emit(
      VotableEvent(
        eventId: '2',
        endsAt: DateTime.now().toUtc().add(const Duration(days: 1)),
        track: EventItemType.ngPoland,
      ),
    );
    cubit = open();
    await Future<void>.delayed(const Duration(milliseconds: 40));
    expect(cubit.state.showButton, isFalse);
  });

  test('shows the like button after the talk has ended', () async {
    votable.emit(
      VotableEvent(
        eventId: '2',
        endsAt: DateTime.utc(2000),
        track: EventItemType.ngPoland,
      ),
    );
    cubit = open();
    await pumpUntil(() => cubit.state.showButton);
    expect(cubit.state.liked, isFalse);
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

Future<void> pumpUntil(bool Function() condition) async {
  for (var i = 0; i < 50 && !condition(); i++) {
    await Future<void>.delayed(const Duration(milliseconds: 10));
  }
}

class _FakeVotableEvents implements VotableEventRepository {
  final _events = BehaviorSubject<VotableEvent?>.seeded(null);

  void emit(VotableEvent? event) => _events.add(event);

  Future<void> dispose() => _events.close();

  @override
  Future<Map<String, VotableEvent>> loadEvents(String confId) async => const {};

  @override
  Future<void> replaceCatalog({
    required String confId,
    required List<VotableEvent> events,
  }) async {}

  @override
  Stream<VotableEvent?> watchEvent({
    required String confId,
    required String eventId,
  }) => _events.stream;
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

class _FakeConfigRepository implements EngagementConfigRepository {
  _FakeConfigRepository(this._config);

  final EngagementConfig _config;

  @override
  Future<void> saveTrackConfig({
    required String confId,
    required EventItemType track,
    required TrackEngagementConfig config,
  }) async {}

  @override
  Stream<EngagementConfig> watchConfig(String confId) => Stream.value(_config);
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
