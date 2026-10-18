import 'package:logger/logger.dart';
import 'package:ng_poland_conf_app/core/domain/repositories/connectivity_repository.dart';
import 'package:ng_poland_conf_app/core/domain/usecases/watch_connectivity.dart';
import 'package:ng_poland_conf_app/core/presentation/cubit/connectivity_cubit.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/auth_user.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_role.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_session.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/exceptions/auth_exception.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/repositories/incoming_links_repository.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/repositories/user_repository.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/repositories/user_session_repository.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/conference.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/edition.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/edition/domain/exceptions/edition_unavailable_exception.dart';
import 'package:ng_poland_conf_app/features/edition/domain/repositories/edition_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/entities/event_vote_counts.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/entities/votable_event.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/repositories/engagement_config_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/repositories/event_vote_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/repositories/votable_event_repository.dart';
import 'package:ng_poland_conf_app/features/home/domain/repositories/conference_repository.dart';
import 'package:rxdart/rxdart.dart';

/// Logger that prints nothing, for code under test.
final silentLogger = Logger(level: Level.off);

const adminProfile = UserProfile(
  uid: 'a1',
  displayName: 'Admin',
  email: 'admin@example.com',
  role: UserRole.admin,
);

const userProfile = UserProfile(
  uid: 'u1',
  displayName: 'Ada',
  email: 'ada@example.com',
  role: UserRole.user,
);

const testAuthUser = AuthUser(
  uid: 'u1',
  displayName: 'Ada',
  email: 'ada@example.com',
);

class FakeAuthenticationRepository implements AuthenticationRepository {
  final authUsers = BehaviorSubject<AuthUser?>.seeded(null);

  /// When set, every sign-in method fails with it.
  AuthException? failure;

  /// Links accepted by [isSignInLink].
  Set<String> signInLinks = const {};
  String? lastSentEmail;
  String? lastCompletedLink;
  int signOutCalls = 0;

  Future<AuthUser> _signIn() async {
    if (failure case final error?) throw error;
    authUsers.add(testAuthUser);
    return testAuthUser;
  }

  @override
  Stream<AuthUser?> watchAuthUser() => authUsers.stream;

  @override
  bool isSignInLink(String link) => signInLinks.contains(link);

  @override
  Future<AuthUser> signInWithGoogle() => _signIn();

  @override
  Future<AuthUser> signInWithApple() => _signIn();

  @override
  Future<void> sendSignInLink(String email) async {
    if (failure case final error?) throw error;
    lastSentEmail = email;
  }

  @override
  Future<AuthUser> completeSignInWithEmailLink(String emailLink) {
    lastCompletedLink = emailLink;
    return _signIn();
  }

  @override
  Future<void> signOut() async {
    signOutCalls++;
    authUsers.add(null);
  }

  Future<void> dispose() => authUsers.close();
}

class FakeUserRepository implements UserRepository {
  FakeUserRepository({
    this.profile,
    this.ensureError,
    this.watchError,
    this.watchStreamError = false,
  });

  final UserProfile? profile;
  final Object? ensureError;

  /// Thrown synchronously by [watchProfile].
  final Object? watchError;

  /// Makes the [watchProfile] stream emit an error.
  final bool watchStreamError;
  var watchAttached = false;

  @override
  Future<UserProfile> ensureProfile({
    required String uid,
    required String displayName,
    required String email,
  }) async {
    if (ensureError case final error?) throw error;
    return profile ??
        UserProfile(
          uid: uid,
          displayName: displayName,
          email: email,
          role: UserRole.user,
        );
  }

  @override
  Stream<UserProfile?> watchProfile(String uid) {
    watchAttached = true;
    if (watchError case final error?) throw error;
    if (watchStreamError) return Stream.error(Exception('snapshot failed'));
    return Stream.value(profile);
  }
}

class FakeIncomingLinksRepository implements IncomingLinksRepository {
  FakeIncomingLinksRepository({this.initial});

  final Uri? initial;
  final _links = BehaviorSubject<Uri>();

  void receive(Uri uri) => _links.add(uri);

  @override
  Future<Uri?> initialLink() async => initial;

  @override
  Stream<Uri> get links => _links.stream;

  Future<void> dispose() => _links.close();
}

class FakeUserSessionRepository implements UserSessionRepository {
  FakeUserSessionRepository([UserSession initial = const UserSession.loading()])
    : _session = BehaviorSubject.seeded(initial);

  final BehaviorSubject<UserSession> _session;

  void emit(UserSession session) => _session.add(session);

  @override
  UserSession get current => _session.value;

  @override
  Stream<UserSession> watch() => _session.stream;

  Future<void> dispose() => _session.close();
}

class FakeConferenceRepository implements ConferenceRepository {
  FakeConferenceRepository([Conference? initial]) {
    if (initial != null) _current.add(initial);
  }

  final _current = BehaviorSubject<Conference>();

  @override
  Conference? get current => _current.valueOrNull;

  @override
  Future<Conference> loadCurrent() async => _current.value;

  @override
  Stream<Conference> watchCurrent() => _current.stream;

  Future<void> dispose() => _current.close();
}

class FakeEditionRepository implements EditionRepository {
  FakeEditionRepository({this.edition, this.refreshed});

  Edition? edition;

  /// Returned by [refresh]; `null` makes it fail like an offline device.
  Edition? refreshed;

  @override
  Future<Edition> load() async =>
      edition ?? (throw const EditionUnavailableException());

  @override
  Future<Edition> refresh() async =>
      refreshed ?? (throw const EditionUnavailableException());
}

class FakeEngagementConfigRepository implements EngagementConfigRepository {
  FakeEngagementConfigRepository(EngagementConfig config)
    : _config = BehaviorSubject.seeded(config);

  final BehaviorSubject<EngagementConfig> _config;
  String? lastSavedConfId;
  EventItemType? lastSavedTrackType;
  TrackEngagementConfig? lastSavedTrack;

  @override
  Stream<EngagementConfig> watchConfig(String confId) => _config.stream;

  @override
  Future<void> saveTrackConfig({
    required String confId,
    required EventItemType track,
    required TrackEngagementConfig config,
  }) async {
    lastSavedConfId = confId;
    lastSavedTrackType = track;
    lastSavedTrack = config;
    _config.add(_config.value.withTrack(track, config));
  }

  Future<void> dispose() => _config.close();
}

class FakeEventVoteRepository implements EventVoteRepository {
  final _likes = BehaviorSubject<Set<String>>.seeded(const {});
  Map<String, EventVoteCounts> counts = const {};
  Object? setLikeError;
  final setLikeCalls = <({String eventId, bool liked})>[];

  @override
  Stream<bool> watchMyLike({
    required String confId,
    required String eventId,
    required String uid,
  }) => _likes.stream.map((ids) => ids.contains(eventId)).distinct();

  @override
  Future<void> setLike({
    required String confId,
    required String eventId,
    required String uid,
    required bool liked,
  }) async {
    setLikeCalls.add((eventId: eventId, liked: liked));
    if (setLikeError case final error?) throw error;
    _likes.add(
      liked ? {..._likes.value, eventId} : ({..._likes.value}..remove(eventId)),
    );
  }

  @override
  Future<Map<String, EventVoteCounts>> loadVoteCounts(String confId) async =>
      counts;

  Future<void> dispose() => _likes.close();
}

class FakeVotableEventRepository implements VotableEventRepository {
  FakeVotableEventRepository([this.events = const {}]);

  Map<String, VotableEvent> events;
  int replaceCalls = 0;
  String? lastConfId;
  List<VotableEvent>? lastEvents;

  @override
  Stream<VotableEvent?> watchEvent({
    required String confId,
    required String eventId,
  }) => Stream.value(events[eventId]);

  @override
  Future<Map<String, VotableEvent>> loadEvents(String confId) async => events;

  @override
  Future<void> replaceCatalog({
    required String confId,
    required List<VotableEvent> events,
  }) async {
    replaceCalls++;
    lastConfId = confId;
    lastEvents = events;
  }
}

class FakeConnectivityRepository implements ConnectivityRepository {
  const FakeConnectivityRepository({this.online = true});

  final bool online;

  @override
  Stream<bool> watchOnline() => Stream.value(online);
}

/// [ConnectivityCubit] reporting a fixed online state.
ConnectivityCubit fakeConnectivityCubit({bool online = true}) =>
    ConnectivityCubit(
      WatchConnectivity(FakeConnectivityRepository(online: online)),
    );

/// Polls [condition] for up to half a second.
Future<void> pumpUntil(bool Function() condition) async {
  for (var i = 0; i < 50 && !condition(); i++) {
    await Future<void>.delayed(const Duration(milliseconds: 10));
  }
}
