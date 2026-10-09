import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/cubit/admin_cubit.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_role.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/repositories/user_repository.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/usecases/ensure_user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/user_session_cubit.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/event_vote_counts.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/engagement_config_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/event_vote_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/votable_event_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/votable_event.dart';
import 'package:ng_poland_conf_app/features/edition/datasources/repositories/edition_repository.dart';
import 'package:ng_poland_conf_app/features/edition/domains/repositories/edition_store.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conference.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conferences.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tzdata;

TrackEngagementConfig _track({
  bool votingEnabled = true,
  bool top5Enabled = false,
}) {
  return TrackEngagementConfig(
    votingEnabled: votingEnabled,
    votingStartsAt: DateTime.utc(2026, 1, 1),
    votingEndsAt: DateTime.utc(2026, 12, 31),
    top5Enabled: top5Enabled,
  );
}

EngagementConfig _config(TrackEngagementConfig track) {
  return EngagementConfig(
    tracks: {for (final type in EventItemType.values) type: track},
  );
}

void main() {
  setUpAll(tzdata.initializeTimeZones);

  late _FakeConfigRepository configRepo;
  late _TestConferencesCubit conferences;
  late _TestUserSessionCubit session;
  late _FakeVotableEventRepository votableEvents;
  late _ScriptedEditionRemote editionRemote;
  late AdminCubit cubit;

  setUp(() async {
    configRepo = _FakeConfigRepository(_config(_track()));
    conferences = _TestConferencesCubit()
      ..load(const Conference(confId: '2026', confName: 'NG', listItems: []));
    session = _TestUserSessionCubit()..signInAdmin();
    votableEvents = _FakeVotableEventRepository();
    editionRemote = _ScriptedEditionRemote();
    cubit = AdminCubit(
      configRepo,
      _FakeVoteRepository(),
      EditionRepository(editionRemote, _EmptyEditionCache()),
      votableEvents,
      session,
      conferences,
    );
    await pumpUntil(
      () => cubit.state.selectedConfId == '2026' && cubit.state.config != null,
    );
  });

  tearDown(() async {
    await cubit.close();
    await session.close();
    await conferences.close();
    await configRepo.dispose();
  });

  test('endVotingNow sets votingEndsAt to now for selected track', () async {
    final before = DateTime.now().toUtc();
    await cubit.endVotingNow();
    final saved = configRepo.lastSavedTrack;
    expect(saved, isNotNull);
    expect(configRepo.lastSavedTrackType, EventItemType.ngPoland);
    expect(
      saved!.votingEndsAt.isAfter(before.subtract(const Duration(seconds: 2))),
      isTrue,
    );
  });

  test('saveTop5Enabled persists flag for selected track', () async {
    await cubit.saveTop5Enabled(true);
    expect(configRepo.lastSavedTrack?.top5Enabled, isTrue);
    expect(configRepo.lastSavedTrackType, EventItemType.ngPoland);
  });

  test('selectTrack filters ranking track', () async {
    expect(cubit.state.availableTracks, contains(EventItemType.aiPoland));
    cubit.selectTrack(EventItemType.jsPoland);
    await pumpUntil(() => cubit.state.selectedTrack == EventItemType.jsPoland);
    expect(cubit.state.selectedTrack, EventItemType.jsPoland);

    await cubit.saveTop5Enabled(true);
    expect(configRepo.lastSavedTrackType, EventItemType.jsPoland);
  });

  test('syncVotableEvents writes the agenda allowlist', () async {
    editionRemote.next = {
      'agenda': EditionFetch.ok(body: _syncAgenda, etag: 'a'),
      'speakers': EditionFetch.ok(body: _syncSpeakers, etag: 's'),
    };

    await cubit.syncVotableEvents();

    expect(votableEvents.replaceCalls, 1);
    expect(votableEvents.lastConfId, '2026');
    expect(votableEvents.lastEvents?.single.eventId, '2');
    expect(cubit.state.message, 'Synced 1 votable event');
  });

  test(
    'syncVotableEvents does not write when the agenda request fails',
    () async {
      editionRemote.fail = true;

      await cubit.syncVotableEvents();

      expect(votableEvents.replaceCalls, 0);
      expect(cubit.state.message, 'Could not sync votable events');
    },
  );
}

Future<void> pumpUntil(bool Function() condition) async {
  for (var i = 0; i < 50 && !condition(); i++) {
    await Future<void>.delayed(const Duration(milliseconds: 10));
  }
}

class _TestConferencesCubit extends ConferencesCubit {
  void load(Conference conference) {
    loadMany([conference]);
  }

  void loadMany(List<Conference> conferences) {
    selectedConference = conferences.first;
    emit(
      ConferencesState.loaded(
        conferences: Conferences(list: conferences),
        selectedConference: conferences.first,
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

class _FakeConfigRepository implements EngagementConfigRepository {
  _FakeConfigRepository(EngagementConfig config)
    : _subject = BehaviorSubject<EngagementConfig>.seeded(config);

  final BehaviorSubject<EngagementConfig> _subject;
  TrackEngagementConfig? lastSavedTrack;
  EventItemType? lastSavedTrackType;
  String? lastWatchedConfId;
  String? lastSavedConfId;

  @override
  Stream<EngagementConfig> watchConfig(String confId) {
    lastWatchedConfId = confId;
    return _subject.stream;
  }

  @override
  Future<void> saveTrackConfig({
    required String confId,
    required EventItemType track,
    required TrackEngagementConfig config,
  }) async {
    lastSavedConfId = confId;
    lastSavedTrackType = track;
    lastSavedTrack = config;
    _subject.add(_subject.value.withTrack(track, config));
  }

  Future<void> dispose() => _subject.close();
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

class _EmptyEditionCache implements EditionCache {
  @override
  Future<EditionCacheEntry?> read(String resource) async => null;

  @override
  Future<void> write(String resource, EditionCacheEntry entry) async {}
}

class _ScriptedEditionRemote implements EditionRemote {
  Map<String, EditionFetch> next = const {};
  bool fail = false;

  @override
  Future<EditionFetch> agenda({String? etag}) => _fetch('agenda');

  @override
  Future<EditionFetch> speakers({String? etag}) => _fetch('speakers');

  Future<EditionFetch> _fetch(String resource) async {
    if (fail) throw Exception('offline');
    return next[resource] ?? (throw StateError('missing $resource'));
  }
}

class _FakeVotableEventRepository implements VotableEventRepository {
  int replaceCalls = 0;
  String? lastConfId;
  List<VotableEvent>? lastEvents;

  @override
  Future<Map<String, VotableEvent>> loadEvents(String confId) async => const {};

  @override
  Future<void> replaceCatalog({
    required String confId,
    required List<VotableEvent> events,
  }) async {
    replaceCalls++;
    lastConfId = confId;
    lastEvents = events;
  }

  @override
  Stream<VotableEvent?> watchEvent({
    required String confId,
    required String eventId,
  }) => const Stream.empty();
}

const _syncAgenda = '''
{
  "year": 2026,
  "days": [
    {
      "key": "ng",
      "kind": "conference",
      "conference": "ng",
      "date": "2026-11-17",
      "published": true,
      "items": [
        {
          "id": 2,
          "isBreak": false,
          "start": "09:00",
          "end": "09:40",
          "title": "Opening Keynote",
          "speakers": [{"name": "Anna", "slug": "anna"}]
        },
        {
          "id": 3,
          "isBreak": true,
          "start": "09:40",
          "end": "10:00",
          "title": "Break",
          "speakers": []
        }
      ]
    },
    {
      "key": "workshops",
      "kind": "workshops",
      "date": "2026-11-16",
      "published": true,
      "items": [
        {"id": 20, "title": "Workshop", "speakers": [{"name": "Anna", "slug": "anna"}]}
      ]
    }
  ]
}
''';

const _syncSpeakers = '{"year": 2026, "speakers": []}';

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
