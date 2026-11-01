# Speaker Voting, Contest, and Admin Panel Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add optional-login speaker thumbs voting, a home-screen contest with admin-controlled windows and drawing, and an admin-only panel, all backed by Firestore on the latest conference.

**Architecture:** Pure domain logic (visibility, vote toggle, draw, home contest view) lives in `features/engagement` with no Firebase imports so it can be unit-tested and later reused behind a custom backend. Flutter datasources talk to Firestore; cubits in auth, speakers, home, and admin consume repositories via GetIt. Admin UI always uses the highest numeric `confId`; user-facing voting/contest UI only appears when the selected conference matches that id.

**Tech Stack:** Flutter 3.x (SDK `>=3.8.0 <4.0.0`), BLoC/Cubit, GetIt/injectable, GoRouter, Firebase Auth, Cloud Firestore, freezed for cubit states, `flutter_test` for unit/widget tests.

## Global Constraints

- Follow existing clean architecture: `domains` / `datasources` / `presentation`, BLoC or Cubit, GetIt + injectable.
- App stays usable logged out. Login is required only for voting, joining the contest, or opening `/admin`.
- Do not enable the commented-out global auth redirect in `routing.dart`.
- Do not change event star ratings (`conf/{confId}/{eventItemType}/{eventId}/rates/{uid}`).
- Voting and contest apply only to the latest conference: highest numeric `confId`.
- The app never writes `role: admin`; first login creates `users/{uid}` with `role: user`.
- Exact user-facing copy:
  - Join button: `Dołącz do konkursu`
  - Joined: `Dołączono do konkursu`
  - Win dialog title: `Gratulacje!`
  - Win body: `Wygrałeś nagrodę w konkursie. Odebrać możesz ją w strefie organizatorów.`
  - Lose banner: `Niestety nie udało się, może innym razem`
- No Cloud Functions in v1. Client + Firestore + basic security rules.
- Work in `ng_poland_conf_app/`. Run tests with `flutter test <path>` from that directory.
- After adding `@injectable` / `@singleton` / freezed cubits, run: `dart run build_runner build --delete-conflicting-outputs`
- Firestore document paths must have even segment counts. Spec shorthand `contest/participants/{uid}` is invalid; use the paths in Task 3.

## File structure

```
ng_poland_conf_app/lib/features/engagement/
  domains/entities/engagement_config.dart
  domains/entities/contest_status.dart
  domains/entities/speaker_vote_value.dart
  domains/entities/contest_participant.dart
  domains/entities/contest_winner.dart
  domains/logic/latest_conference_resolver.dart
  domains/logic/engagement_visibility.dart
  domains/logic/contest_home_view.dart
  domains/logic/speaker_vote_toggle.dart
  domains/logic/contest_draw.dart
  domains/repositories/engagement_config_repository.dart
  domains/repositories/speaker_vote_repository.dart
  domains/repositories/contest_repository.dart
  datasources/data/engagement_config_remote_datasource.dart
  datasources/data/speaker_vote_remote_datasource.dart
  datasources/data/contest_remote_datasource.dart
  datasources/repositories/engagement_config_repository.dart
  datasources/repositories/speaker_vote_repository.dart
  datasources/repositories/contest_repository.dart

ng_poland_conf_app/lib/features/authentication/
  domains/entities/user_role.dart
  domains/entities/user_profile.dart
  domains/repositories/user_repository.dart
  domains/usecases/ensure_user_profile.dart
  datasources/data/user_remote_datasource.dart
  datasources/repositories/user_repository.dart
  presentation/cubit/user_session_cubit.dart
  presentation/cubit/user_session_state.dart

ng_poland_conf_app/lib/features/speakers/presentation/
  cubit/speaker_vote_cubit.dart
  widgets/speaker_vote_buttons.dart

ng_poland_conf_app/lib/features/home/presentation/
  cubit/contest_home_cubit.dart
  widgets/contest_home_section.dart

ng_poland_conf_app/lib/features/admin/presentation/
  admin_page.dart
  cubit/admin_cubit.dart

firebase/firestore.rules
ng_poland_conf_app/test/features/...
```

Modify: `authentication_cubit.dart`, `authentication_page.dart`, `authentication_repository` (ensure profile after sign-in), `speaker_details.dart`, `home_page.dart`, `routing.dart`, `custom_drawer.dart`, `main.dart`.

---

### Task 1: Pure domain logic

**Files:**
- Create: `ng_poland_conf_app/lib/features/engagement/domains/entities/contest_status.dart`
- Create: `ng_poland_conf_app/lib/features/engagement/domains/entities/speaker_vote_value.dart`
- Create: `ng_poland_conf_app/lib/features/engagement/domains/entities/engagement_config.dart`
- Create: `ng_poland_conf_app/lib/features/engagement/domains/logic/latest_conference_resolver.dart`
- Create: `ng_poland_conf_app/lib/features/engagement/domains/logic/engagement_visibility.dart`
- Create: `ng_poland_conf_app/lib/features/engagement/domains/logic/contest_home_view.dart`
- Create: `ng_poland_conf_app/lib/features/engagement/domains/logic/speaker_vote_toggle.dart`
- Create: `ng_poland_conf_app/lib/features/engagement/domains/logic/contest_draw.dart`
- Test: `ng_poland_conf_app/test/features/engagement/domains/logic/engagement_logic_test.dart`

**Interfaces:**
- Consumes: nothing
- Produces:
  - `enum ContestStatus { idle, open, drawing, finished }` with `ContestStatusX.fromId(String)`
  - `enum SpeakerVoteValue { up, down }` (`up` → Firestore `1`, `down` → `-1`)
  - `class EngagementConfig` with `isVotingOpen(DateTime now)`, `isContestJoinOpen(DateTime now)`
  - `LatestConferenceResolver.fromConfIds(Iterable<String> ids) → String?`
  - `enum ContestHomeView { hidden, join, joined, winner, loser }` and `ContestHomeViewResolver.resolve(...)`
  - `SpeakerVoteToggle.apply({SpeakerVoteValue? current, required SpeakerVoteValue tapped}) → SpeakerVoteValue?`
  - `ContestDraw.pick({required List<String> participantIds, required Set<String> winnerIds, required int count, required Random random}) → List<String>`

- [ ] **Step 1: Write the failing test**

Create `ng_poland_conf_app/test/features/engagement/domains/logic/engagement_logic_test.dart`:

```dart
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_status.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/speaker_vote_value.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/contest_draw.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/contest_home_view.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/engagement_visibility.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/latest_conference_resolver.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/speaker_vote_toggle.dart';

void main() {
  group('LatestConferenceResolver', () {
    test('returns highest numeric confId', () {
      expect(
        LatestConferenceResolver.fromConfIds(['2018', '2026', '2025']),
        '2026',
      );
    });

    test('ignores non-numeric ids', () {
      expect(
        LatestConferenceResolver.fromConfIds(['ng', '2024']),
        '2024',
      );
    });

    test('returns null when empty', () {
      expect(LatestConferenceResolver.fromConfIds([]), isNull);
    });
  });

  group('EngagementConfig windows', () {
    final now = DateTime.utc(2026, 11, 20, 12);

    test('voting open only when enabled and now inside window', () {
      final config = EngagementConfig(
        votingEnabled: true,
        votingStartsAt: DateTime.utc(2026, 11, 20, 9),
        votingEndsAt: DateTime.utc(2026, 11, 21, 18),
        contestEnabled: false,
        contestStartsAt: now,
        contestEndsAt: now,
        contestStatus: ContestStatus.idle,
      );
      expect(config.isVotingOpen(now), isTrue);
      expect(config.isVotingOpen(DateTime.utc(2026, 11, 19)), isFalse);
    });

    test('contest join open when enabled, in window, status idle or open', () {
      final config = EngagementConfig(
        votingEnabled: false,
        votingStartsAt: now,
        votingEndsAt: now,
        contestEnabled: true,
        contestStartsAt: DateTime.utc(2026, 11, 20, 10),
        contestEndsAt: DateTime.utc(2026, 11, 20, 16),
        contestStatus: ContestStatus.open,
      );
      expect(config.isContestJoinOpen(now), isTrue);
      expect(
        config.copyWith(contestStatus: ContestStatus.drawing).isContestJoinOpen(now),
        isFalse,
      );
    });
  });

  group('EngagementVisibility', () {
    test('hides voting when selected conference is not latest', () {
      expect(
        EngagementVisibility.showVoting(
          selectedConfId: '2025',
          latestConfId: '2026',
          votingOpen: true,
        ),
        isFalse,
      );
    });
  });

  group('ContestHomeViewResolver', () {
    final openConfig = EngagementConfig(
      votingEnabled: false,
      votingStartsAt: DateTime.utc(2026, 1, 1),
      votingEndsAt: DateTime.utc(2026, 1, 1),
      contestEnabled: true,
      contestStartsAt: DateTime.utc(2026, 11, 20, 10),
      contestEndsAt: DateTime.utc(2026, 11, 20, 16),
      contestStatus: ContestStatus.open,
    );
    final now = DateTime.utc(2026, 11, 20, 12);

    test('join when latest, open, not participating', () {
      expect(
        ContestHomeViewResolver.resolve(
          isLatestConference: true,
          config: openConfig,
          now: now,
          isParticipant: false,
          isWinner: false,
        ),
        ContestHomeView.join,
      );
    });

    test('joined when participating and still open', () {
      expect(
        ContestHomeViewResolver.resolve(
          isLatestConference: true,
          config: openConfig,
          now: now,
          isParticipant: true,
          isWinner: false,
        ),
        ContestHomeView.joined,
      );
    });

    test('winner as soon as drawn, even before finished', () {
      expect(
        ContestHomeViewResolver.resolve(
          isLatestConference: true,
          config: openConfig.copyWith(contestStatus: ContestStatus.drawing),
          now: now,
          isParticipant: true,
          isWinner: true,
        ),
        ContestHomeView.winner,
      );
    });

    test('loser only when finished, participant, not winner', () {
      expect(
        ContestHomeViewResolver.resolve(
          isLatestConference: true,
          config: openConfig.copyWith(contestStatus: ContestStatus.finished),
          now: now,
          isParticipant: true,
          isWinner: false,
        ),
        ContestHomeView.loser,
      );
    });

    test('non-participants see hidden after finish', () {
      expect(
        ContestHomeViewResolver.resolve(
          isLatestConference: true,
          config: openConfig.copyWith(contestStatus: ContestStatus.finished),
          now: now,
          isParticipant: false,
          isWinner: false,
        ),
        ContestHomeView.hidden,
      );
    });

    test('hidden on historical conference', () {
      expect(
        ContestHomeViewResolver.resolve(
          isLatestConference: false,
          config: openConfig,
          now: now,
          isParticipant: false,
          isWinner: false,
        ),
        ContestHomeView.hidden,
      );
    });
  });

  group('SpeakerVoteToggle', () {
    test('same thumb clears vote', () {
      expect(
        SpeakerVoteToggle.apply(
          current: SpeakerVoteValue.up,
          tapped: SpeakerVoteValue.up,
        ),
        isNull,
      );
    });

    test('other thumb switches vote', () {
      expect(
        SpeakerVoteToggle.apply(
          current: SpeakerVoteValue.up,
          tapped: SpeakerVoteValue.down,
        ),
        SpeakerVoteValue.down,
      );
    });

    test('no vote then up sets up', () {
      expect(
        SpeakerVoteToggle.apply(current: null, tapped: SpeakerVoteValue.up),
        SpeakerVoteValue.up,
      );
    });
  });

  group('ContestDraw', () {
    test('excludes existing winners and caps to pool size', () {
      final picked = ContestDraw.pick(
        participantIds: ['a', 'b', 'c'],
        winnerIds: {'b'},
        count: 5,
        random: Random(1),
      );
      expect(picked.length, 2);
      expect(picked.toSet().intersection({'b'}), isEmpty);
      expect(picked.toSet().intersection({'a', 'c'}).length, 2);
    });

    test('empty pool returns empty and does not throw', () {
      expect(
        ContestDraw.pick(
          participantIds: ['a'],
          winnerIds: {'a'},
          count: 1,
          random: Random(1),
        ),
        isEmpty,
      );
    });
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run from `ng_poland_conf_app`:

```bash
flutter test test/features/engagement/domains/logic/engagement_logic_test.dart
```

Expected: FAIL — missing libraries / Target of URI hasn't been created.

- [ ] **Step 3: Write minimal implementation**

`contest_status.dart`:

```dart
enum ContestStatus { idle, open, drawing, finished }

extension ContestStatusX on ContestStatus {
  String get id => name;

  static ContestStatus fromId(String? raw) {
    return ContestStatus.values.firstWhere(
      (value) => value.name == raw,
      orElse: () => ContestStatus.idle,
    );
  }
}
```

`speaker_vote_value.dart`:

```dart
enum SpeakerVoteValue {
  up,
  down;

  int get firestoreValue => switch (this) {
        SpeakerVoteValue.up => 1,
        SpeakerVoteValue.down => -1,
      };

  static SpeakerVoteValue? fromFirestore(int? value) {
    return switch (value) {
      1 => SpeakerVoteValue.up,
      -1 => SpeakerVoteValue.down,
      _ => null,
    };
  }
}
```

`engagement_config.dart`:

```dart
import 'contest_status.dart';

class EngagementConfig {
  const EngagementConfig({
    required this.votingEnabled,
    required this.votingStartsAt,
    required this.votingEndsAt,
    required this.contestEnabled,
    required this.contestStartsAt,
    required this.contestEndsAt,
    required this.contestStatus,
  });

  final bool votingEnabled;
  final DateTime votingStartsAt;
  final DateTime votingEndsAt;
  final bool contestEnabled;
  final DateTime contestStartsAt;
  final DateTime contestEndsAt;
  final ContestStatus contestStatus;

  static final missing = EngagementConfig(
    votingEnabled: false,
    votingStartsAt: DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
    votingEndsAt: DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
    contestEnabled: false,
    contestStartsAt: DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
    contestEndsAt: DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
    contestStatus: ContestStatus.idle,
  );

  bool isVotingOpen(DateTime now) {
    return votingEnabled && _inWindow(now, votingStartsAt, votingEndsAt);
  }

  bool isContestJoinOpen(DateTime now) {
    final statusAllowsJoin =
        contestStatus == ContestStatus.idle || contestStatus == ContestStatus.open;
    return contestEnabled &&
        statusAllowsJoin &&
        _inWindow(now, contestStartsAt, contestEndsAt);
  }

  EngagementConfig copyWith({
    bool? votingEnabled,
    DateTime? votingStartsAt,
    DateTime? votingEndsAt,
    bool? contestEnabled,
    DateTime? contestStartsAt,
    DateTime? contestEndsAt,
    ContestStatus? contestStatus,
  }) {
    return EngagementConfig(
      votingEnabled: votingEnabled ?? this.votingEnabled,
      votingStartsAt: votingStartsAt ?? this.votingStartsAt,
      votingEndsAt: votingEndsAt ?? this.votingEndsAt,
      contestEnabled: contestEnabled ?? this.contestEnabled,
      contestStartsAt: contestStartsAt ?? this.contestStartsAt,
      contestEndsAt: contestEndsAt ?? this.contestEndsAt,
      contestStatus: contestStatus ?? this.contestStatus,
    );
  }

  static bool _inWindow(DateTime now, DateTime start, DateTime end) {
    return !now.isBefore(start) && !now.isAfter(end);
  }
}
```

`latest_conference_resolver.dart`:

```dart
class LatestConferenceResolver {
  const LatestConferenceResolver._();

  static String? fromConfIds(Iterable<String> ids) {
    final parsed = <({String id, int year})>[];
    for (final id in ids) {
      final year = int.tryParse(id);
      if (year != null) {
        parsed.add((id: id, year: year));
      }
    }
    if (parsed.isEmpty) return null;
    parsed.sort((a, b) => b.year.compareTo(a.year));
    return parsed.first.id;
  }
}
```

`engagement_visibility.dart`:

```dart
class EngagementVisibility {
  const EngagementVisibility._();

  static bool showVoting({
    required String? selectedConfId,
    required String? latestConfId,
    required bool votingOpen,
  }) {
    if (selectedConfId == null || latestConfId == null) return false;
    return selectedConfId == latestConfId && votingOpen;
  }
}
```

`contest_home_view.dart`:

```dart
import '../entities/contest_status.dart';
import '../entities/engagement_config.dart';

enum ContestHomeView { hidden, join, joined, winner, loser }

class ContestHomeViewResolver {
  const ContestHomeViewResolver._();

  static ContestHomeView resolve({
    required bool isLatestConference,
    required EngagementConfig config,
    required DateTime now,
    required bool isParticipant,
    required bool isWinner,
  }) {
    if (!isLatestConference) return ContestHomeView.hidden;
    if (isWinner) return ContestHomeView.winner;
    if (isParticipant) {
      if (config.contestStatus == ContestStatus.finished) {
        return ContestHomeView.loser;
      }
      if (config.isContestJoinOpen(now) ||
          config.contestStatus == ContestStatus.drawing) {
        return ContestHomeView.joined;
      }
    }
    if (config.isContestJoinOpen(now) && !isParticipant) {
      return ContestHomeView.join;
    }
    return ContestHomeView.hidden;
  }
}
```

`speaker_vote_toggle.dart`:

```dart
import '../entities/speaker_vote_value.dart';

class SpeakerVoteToggle {
  const SpeakerVoteToggle._();

  static SpeakerVoteValue? apply({
    SpeakerVoteValue? current,
    required SpeakerVoteValue tapped,
  }) {
    if (current == tapped) return null;
    return tapped;
  }
}
```

`contest_draw.dart`:

```dart
import 'dart:math';

class ContestDraw {
  const ContestDraw._();

  static List<String> pick({
    required List<String> participantIds,
    required Set<String> winnerIds,
    required int count,
    required Random random,
  }) {
    final pool = participantIds.where((id) => !winnerIds.contains(id)).toList();
    if (pool.isEmpty || count <= 0) return const [];
    pool.shuffle(random);
    final take = count > pool.length ? pool.length : count;
    return pool.take(take).toList();
  }
}
```

- [ ] **Step 4: Run tests and make sure they pass**

```bash
flutter test test/features/engagement/domains/logic/engagement_logic_test.dart
```

Expected: PASS (all groups).

- [ ] **Step 5: Commit**

```bash
git add ng_poland_conf_app/lib/features/engagement/domains ng_poland_conf_app/test/features/engagement
git commit -m "Add engagement domain logic for voting, contest, and draws."
```

---

### Task 2: User profile, session cubit, login-and-return

**Files:**
- Create: `ng_poland_conf_app/lib/features/authentication/domains/entities/user_role.dart`
- Create: `ng_poland_conf_app/lib/features/authentication/domains/entities/user_profile.dart`
- Create: `ng_poland_conf_app/lib/features/authentication/domains/repositories/user_repository.dart`
- Create: `ng_poland_conf_app/lib/features/authentication/datasources/data/user_remote_datasource.dart`
- Create: `ng_poland_conf_app/lib/features/authentication/datasources/repositories/user_repository.dart`
- Create: `ng_poland_conf_app/lib/features/authentication/domains/usecases/ensure_user_profile.dart`
- Create: `ng_poland_conf_app/lib/features/authentication/presentation/cubit/user_session_state.dart`
- Create: `ng_poland_conf_app/lib/features/authentication/presentation/cubit/user_session_cubit.dart`
- Modify: `ng_poland_conf_app/lib/features/authentication/presentation/cubit/authentication_cubit.dart`
- Modify: `ng_poland_conf_app/lib/features/authentication/presentation/authentication_page.dart`
- Modify: `ng_poland_conf_app/lib/routing/routing.dart`
- Modify: `ng_poland_conf_app/lib/main.dart`
- Test: `ng_poland_conf_app/test/features/authentication/domains/usecases/ensure_user_profile_test.dart`

**Interfaces:**
- Consumes: Firebase Auth `User` (`uid`, `displayName`, `email`)
- Produces:
  - `enum UserRole { user, admin }`
  - `class UserProfile { uid, displayName, email, role }`
  - `UserRepository.ensureProfile(...)` / `watchProfile(uid)`
  - `EnsureUserProfile.call(EnsureUserProfileParams)`
  - `UserSessionCubit` state: `unauthenticated` | `loading` | `authenticated(UserProfile)`
  - `UserSessionCubit.isAdmin`, `currentProfile`
  - Auth route query `from` — after success, `context.go(from)` if present else `context.pop()` if `canPop` else `context.go('/')`

- [ ] **Step 1: Write the failing test**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_role.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/repositories/user_repository.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/usecases/ensure_user_profile.dart';

class _FakeUserRepository implements UserRepository {
  UserProfile? stored;
  bool created = false;

  @override
  Future<UserProfile> ensureProfile({
    required String uid,
    required String displayName,
    required String email,
  }) async {
    if (stored != null) return stored!;
    created = true;
    stored = UserProfile(
      uid: uid,
      displayName: displayName,
      email: email,
      role: UserRole.user,
    );
    return stored!;
  }

  @override
  Stream<UserProfile?> watchProfile(String uid) => Stream.value(stored);
}

void main() {
  test('creates user role profile when missing', () async {
    final repo = _FakeUserRepository();
    final useCase = EnsureUserProfile(repo);
    final profile = await useCase(
      const EnsureUserProfileParams(
        uid: 'u1',
        displayName: 'Ada',
        email: 'ada@example.com',
      ),
    );
    expect(profile.role, UserRole.user);
    expect(repo.created, isTrue);
  });

  test('does not overwrite an existing admin profile', () async {
    final repo = _FakeUserRepository()
      ..stored = const UserProfile(
        uid: 'u1',
        displayName: 'Ada',
        email: 'ada@example.com',
        role: UserRole.admin,
      );
    final useCase = EnsureUserProfile(repo);
    final profile = await useCase(
      const EnsureUserProfileParams(
        uid: 'u1',
        displayName: 'Ada',
        email: 'ada@example.com',
      ),
    );
    expect(profile.role, UserRole.admin);
    expect(repo.created, isFalse);
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

```bash
flutter test test/features/authentication/domains/usecases/ensure_user_profile_test.dart
```

Expected: FAIL — missing types.

- [ ] **Step 3: Write entities, repository, datasource, use case, cubit**

`user_role.dart`:

```dart
enum UserRole {
  user,
  admin;

  static UserRole fromId(String? raw) {
    if (raw == 'admin') return UserRole.admin;
    return UserRole.user;
  }

  String get id => name;
}
```

`user_profile.dart`:

```dart
import 'user_role.dart';

class UserProfile {
  const UserProfile({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.role,
  });

  final String uid;
  final String displayName;
  final String email;
  final UserRole role;

  bool get isAdmin => role == UserRole.admin;
}
```

`domains/repositories/user_repository.dart`:

```dart
import '../entities/user_profile.dart';

abstract interface class UserRepository {
  Future<UserProfile> ensureProfile({
    required String uid,
    required String displayName,
    required String email,
  });

  Stream<UserProfile?> watchProfile(String uid);
}
```

`user_remote_datasource.dart`:

```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_role.dart';

@injectable
class UserRemoteDataSource {
  UserRemoteDataSource({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  DocumentReference<Map<String, dynamic>> _doc(String uid) =>
      _firestore.collection('users').doc(uid);

  Future<UserProfile> ensureProfile({
    required String uid,
    required String displayName,
    required String email,
  }) async {
    final snapshot = await _doc(uid).get();
    if (snapshot.exists) {
      return _fromDoc(uid, snapshot.data()!);
    }
    await _doc(uid).set({
      'displayName': displayName,
      'email': email,
      'role': UserRole.user.id,
      'createdAt': FieldValue.serverTimestamp(),
    });
    return UserProfile(
      uid: uid,
      displayName: displayName,
      email: email,
      role: UserRole.user,
    );
  }

  Stream<UserProfile?> watchProfile(String uid) {
    return _doc(uid).snapshots().map((snapshot) {
      final data = snapshot.data();
      if (!snapshot.exists || data == null) return null;
      return _fromDoc(uid, data);
    });
  }

  UserProfile _fromDoc(String uid, Map<String, dynamic> data) {
    return UserProfile(
      uid: uid,
      displayName: data['displayName'] as String? ?? '',
      email: data['email'] as String? ?? '',
      role: UserRole.fromId(data['role'] as String?),
    );
  }
}
```

Repository impl `@Singleton(as: UserRepository)` delegating to the datasource.

`ensure_user_profile.dart`:

```dart
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/usecases/usecases.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/repositories/user_repository.dart';

@injectable
class EnsureUserProfile implements UseCase<UserProfile, EnsureUserProfileParams> {
  const EnsureUserProfile(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<UserProfile> call(EnsureUserProfileParams params) {
    return _userRepository.ensureProfile(
      uid: params.uid,
      displayName: params.displayName,
      email: params.email,
    );
  }
}

class EnsureUserProfileParams {
  const EnsureUserProfileParams({
    required this.uid,
    required this.displayName,
    required this.email,
  });

  final String uid;
  final String displayName;
  final String email;
}
```

`user_session_state.dart` as `part of 'user_session_cubit.dart'`:

```dart
part of 'user_session_cubit.dart';

@freezed
class UserSessionState with _$UserSessionState {
  const UserSessionState._();

  const factory UserSessionState.unauthenticated() = _Unauthenticated;
  const factory UserSessionState.loading() = _Loading;
  const factory UserSessionState.authenticated(UserProfile profile) = _Authenticated;

  bool get isAdmin => maybeWhen(
        authenticated: (profile) => profile.isAdmin,
        orElse: () => false,
      );

  UserProfile? get profile => maybeWhen(
        authenticated: (profile) => profile,
        orElse: () => null,
      );
}
```

`user_session_cubit.dart`:

```dart
@singleton
class UserSessionCubit extends Cubit<UserSessionState> {
  UserSessionCubit(this._ensureUserProfile, this._userRepository)
      : super(const UserSessionState.unauthenticated()) {
    _authSub = FirebaseAuth.instance.authStateChanges().listen(_onAuth);
  }

  final EnsureUserProfile _ensureUserProfile;
  final UserRepository _userRepository;
  StreamSubscription<User?>? _authSub;
  StreamSubscription<UserProfile?>? _profileSub;

  Future<void> _onAuth(User? user) async {
    await _profileSub?.cancel();
    if (user == null) {
      emit(const UserSessionState.unauthenticated());
      return;
    }
    emit(const UserSessionState.loading());
    await _ensureUserProfile(
      EnsureUserProfileParams(
        uid: user.uid,
        displayName: user.displayName ?? '',
        email: user.email ?? '',
      ),
    );
    _profileSub = _userRepository.watchProfile(user.uid).listen((profile) {
      if (profile == null) {
        emit(const UserSessionState.unauthenticated());
        return;
      }
      emit(UserSessionState.authenticated(profile));
    });
  }

  @override
  Future<void> close() async {
    await _authSub?.cancel();
    await _profileSub?.cancel();
    return super.close();
  }
}
```

Call `EnsureUserProfile` from `AuthenticationCubit` after successful Google/Apple sign-in, using `FirebaseAuth.instance.currentUser` (`displayName ?? ''`, `email ?? ''`). Empty strings are allowed (spec).

`AuthenticationPage`: wrap with `BlocListener<AuthenticationCubit, AuthenticationState>`. On `authenticated`:

```dart
final from = GoRouterState.of(context).uri.queryParameters['from'];
if (from != null && from.isNotEmpty) {
  context.go(from);
} else if (context.canPop()) {
  context.pop();
} else {
  context.go(Pages.home.path);
}
```

Helper on a small `AuthNavigation` class or static method:

```dart
static String loginPath({String? from}) {
  if (from == null || from.isEmpty) return AuthenticationPage.path;
  return '${AuthenticationPage.path}?from=${Uri.encodeComponent(from)}';
}
```

Put `loginPath` on `AuthenticationPage`.

`routing.dart` redirect: keep global auth disabled. Add:

```dart
if (state.matchedLocation == AdminPage.path) {
  final isAdmin = getIt.get<UserSessionCubit>().state.isAdmin;
  if (!isAdmin) return Pages.home.path;
}
```

(`AdminPage.path` is `/admin` — add a stub `AdminPage` widget in this task so the route compiles: `Scaffold(body: SizedBox.shrink())`, replaced in Task 6.)

`main.dart`: add `BlocProvider(create: (_) => getIt.get<UserSessionCubit>())`.

Run `dart run build_runner build --delete-conflicting-outputs`.

- [ ] **Step 4: Run tests**

```bash
flutter test test/features/authentication/domains/usecases/ensure_user_profile_test.dart
flutter test test/features/engagement/domains/logic/engagement_logic_test.dart
```

Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add ng_poland_conf_app/lib/features/authentication ng_poland_conf_app/lib/features/admin/presentation/admin_page.dart ng_poland_conf_app/lib/routing/routing.dart ng_poland_conf_app/lib/main.dart ng_poland_conf_app/test/features/authentication
git commit -m "Add user profiles, session cubit, and login return navigation."
```

---

### Task 3: Firestore datasources for config, votes, contest

**Files:**
- Create: `ng_poland_conf_app/lib/features/engagement/domains/entities/contest_participant.dart`
- Create: `ng_poland_conf_app/lib/features/engagement/domains/entities/contest_winner.dart`
- Create: `ng_poland_conf_app/lib/features/engagement/domains/repositories/engagement_config_repository.dart`
- Create: `ng_poland_conf_app/lib/features/engagement/domains/repositories/speaker_vote_repository.dart`
- Create: `ng_poland_conf_app/lib/features/engagement/domains/repositories/contest_repository.dart`
- Create matching `datasources/data/*_remote_datasource.dart` and `datasources/repositories/*.dart`

**Interfaces:**
- Consumes: Task 1 entities
- Produces (exact Firestore paths):
  - Config: `conf/{confId}/engagement/config`
  - Vote: `conf/{confId}/speakerVotes/{speakerId}/votes/{uid}`
  - Participants: `conf/{confId}/contestParticipants/{uid}`
  - Winners: `conf/{confId}/contestWinners/{uid}`
- Methods:
  - `Stream<EngagementConfig> watchConfig(String confId)`
  - `Future<void> saveConfig(String confId, EngagementConfig config)`
  - `Stream<SpeakerVoteValue?> watchMyVote({confId, speakerId, uid})`
  - `Future<void> setVote({confId, speakerId, uid, SpeakerVoteValue? value})` — `null` deletes the doc
  - `Stream<Map<String, SpeakerVoteValue>> watchAllVotes({confId, speakerId})` (admin)
  - `Future<Map<String, Map<String, SpeakerVoteValue>>> watchAllSpeakerVotes(String confId)` — see below
  - `Stream<ContestParticipant?> watchMyParticipation({confId, uid})`
  - `Future<void> join({confId, uid, displayName, email})`
  - `Stream<List<ContestParticipant>> watchParticipants(String confId)`
  - `Stream<ContestWinner?> watchMyWin({confId, uid})`
  - `Stream<List<ContestWinner>> watchWinners(String confId)`
  - `Future<void> saveWinners({confId, winners})`
  - `Future<void> updateContestStatus({confId, ContestStatus status})`

For admin ranking, either collection-group query `votes` under `conf/{confId}/speakerVotes` or, simpler in v1: `collection('speakerVotes').get()` then for each speaker doc `collection('votes').get()`. Implement `Future<Map<String, SpeakerVoteCounts>> loadVoteCounts(String confId)` where:

```dart
class SpeakerVoteCounts {
  const SpeakerVoteCounts({required this.up, required this.down});
  final int up;
  final int down;
}
```

- [ ] **Step 1: Write a mapper unit test (no Firebase)**

`ng_poland_conf_app/test/features/engagement/datasources/engagement_mappers_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/engagement/datasources/data/engagement_mappers.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_status.dart';

void main() {
  test('config map round-trip keeps status and flags', () {
    final config = EngagementMappers.configFromMap({
      'votingEnabled': true,
      'votingStartsAt': DateTime.utc(2026, 11, 20, 9),
      'votingEndsAt': DateTime.utc(2026, 11, 21, 18),
      'contestEnabled': true,
      'contestStartsAt': DateTime.utc(2026, 11, 20, 12),
      'contestEndsAt': DateTime.utc(2026, 11, 20, 16),
      'contestStatus': 'open',
    });
    expect(config.votingEnabled, isTrue);
    expect(config.contestStatus, ContestStatus.open);
    final map = EngagementMappers.configToMap(config);
    expect(map['contestStatus'], 'open');
    expect(map['votingEnabled'], isTrue);
  });

  test('missing config map yields disabled defaults', () {
    final config = EngagementMappers.configFromMap(null);
    expect(config.votingEnabled, isFalse);
    expect(config.contestEnabled, isFalse);
    expect(config.contestStatus, ContestStatus.idle);
  });
}
```

Put map conversion in `engagement_mappers.dart` so tests do not need `cloud_firestore` `Timestamp`. Datasources convert `Timestamp` ↔ `DateTime` then call mappers with `DateTime`.

- [ ] **Step 2: Run test to verify it fails**

```bash
flutter test test/features/engagement/datasources/engagement_mappers_test.dart
```

Expected: FAIL — missing `engagement_mappers.dart`.

- [ ] **Step 3: Implement mappers and Firestore datasources**

`engagement_mappers.dart` — `configFromMap` / `configToMap` using `DateTime` (datasource converts Timestamp). Treat missing dates as epoch UTC.

Config datasource watch:

```dart
_firestore
  .collection('conf').doc(confId)
  .collection('engagement').doc('config')
  .snapshots()
  .map((snap) => EngagementMappers.configFromMap(_datesToDateTime(snap.data())));
```

Vote set:

```dart
final ref = _firestore
    .collection('conf').doc(confId)
    .collection('speakerVotes').doc(speakerId)
    .collection('votes').doc(uid);
if (value == null) {
  await ref.delete();
} else {
  await ref.set({
    'value': value.firestoreValue,
    'updatedAt': FieldValue.serverTimestamp(),
  });
}
```

Join:

```dart
await _firestore
    .collection('conf').doc(confId)
    .collection('contestParticipants').doc(uid)
    .set({
      'displayName': displayName,
      'email': email,
      'joinedAt': FieldValue.serverTimestamp(),
    });
```

Winner write:

```dart
await _firestore
    .collection('conf').doc(confId)
    .collection('contestWinners').doc(uid)
    .set({
      'displayName': winner.displayName,
      'email': winner.email,
      'drawnAt': FieldValue.serverTimestamp(),
      'order': winner.order,
    });
```

`updateContestStatus` uses `set(..., SetOptions(merge: true))` on the config doc so a missing config can still receive status.

Entities:

```dart
class ContestParticipant {
  const ContestParticipant({
    required this.uid,
    required this.displayName,
    required this.email,
  });
  final String uid;
  final String displayName;
  final String email;
}

class ContestWinner {
  const ContestWinner({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.order,
  });
  final String uid;
  final String displayName;
  final String email;
  final int order;
}
```

`@Singleton(as: ...)` repository impls. Run build_runner.

- [ ] **Step 4: Run tests**

```bash
flutter test test/features/engagement
```

Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add ng_poland_conf_app/lib/features/engagement ng_poland_conf_app/test/features/engagement
git commit -m "Add Firestore datasources for engagement config, votes, and contest."
```

---

### Task 4: Speaker thumbs on details

**Files:**
- Create: `ng_poland_conf_app/lib/features/speakers/presentation/cubit/speaker_vote_state.dart`
- Create: `ng_poland_conf_app/lib/features/speakers/presentation/cubit/speaker_vote_cubit.dart`
- Create: `ng_poland_conf_app/lib/features/speakers/presentation/widgets/speaker_vote_buttons.dart`
- Modify: `ng_poland_conf_app/lib/features/speakers/presentation/widgets/speaker_details.dart` (insert buttons after the role text, before bio)
- Test: `ng_poland_conf_app/test/features/speakers/presentation/widgets/speaker_vote_buttons_test.dart`

**Interfaces:**
- Consumes: `SpeakerVoteRepository`, `EngagementConfigRepository`, `UserSessionCubit`, `ConferencesCubit`, `LatestConferenceResolver`, `EngagementVisibility`, `SpeakerVoteToggle`
- Produces: `SpeakerVoteCubit` for one `speakerId`; `SpeakerVoteButtons` with `SpeakerVoteValue? current`, `onTap(SpeakerVoteValue)`, `enabled`

- [ ] **Step 1: Write the failing widget test**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/speaker_vote_value.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/widgets/speaker_vote_buttons.dart';

void main() {
  testWidgets('highlights only the user vote and reports taps', (tester) async {
    SpeakerVoteValue? tapped;
    await tester.pumpWidget(
      MaterialApp(
        home: SpeakerVoteButtons(
          current: SpeakerVoteValue.up,
          enabled: true,
          onTap: (value) => tapped = value,
        ),
      ),
    );
    expect(find.byKey(const Key('vote-up')), findsOneWidget);
    expect(find.byKey(const Key('vote-down')), findsOneWidget);
    await tester.tap(find.byKey(const Key('vote-down')));
    expect(tapped, SpeakerVoteValue.down);
  });

  testWidgets('does not show counts', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SpeakerVoteButtons(
          current: SpeakerVoteValue.up,
          enabled: true,
          onTap: _noop,
        ),
      ),
    );
    expect(find.textContaining('128'), findsNothing);
    expect(find.text('👍'), findsNothing);
  });
}

void _noop(SpeakerVoteValue value) {}
```

Use `Icons.thumb_up` / `Icons.thumb_down` (not emoji counts). Selected thumb uses `colorScheme.primary`.

- [ ] **Step 2: Run test to verify it fails**

```bash
flutter test test/features/speakers/presentation/widgets/speaker_vote_buttons_test.dart
```

Expected: FAIL — missing widget.

- [ ] **Step 3: Implement widget + cubit + wire into details**

`SpeakerVoteButtons`: two `IconButton`s, keys `vote-up` / `vote-down`. No numeric `Text`.

`SpeakerVoteCubit` (`@injectable`, factory with `@factoryParam String speakerId`):

State (freezed): `hidden` | `needsLogin` | `ready(SpeakerVoteValue? vote)` | `saving(SpeakerVoteValue? vote)` | `failure(SpeakerVoteValue? vote)`

On create: combine `conferencesCubit.stream` (startWith current), `watchConfig(latestConfId)`, `watchMyVote` if logged in.

- If `!EngagementVisibility.showVoting(...)` → `hidden` (do not show buttons).
- If voting should show and `UserSessionCubit` is unauthenticated → `needsLogin` (still **show** buttons; tap routes to login).
- Spec: thumbs appear when latest + window + enabled. Unauthenticated tap → login. So visible in both `needsLogin` and `ready`.

On tap:
- if unauthenticated: caller pushes `AuthenticationPage.loginPath(from: GoRouterState.of(context).uri.toString())`. Cubit method `bool requiresLogin()` or the widget checks session.
- if authenticated: `next = SpeakerVoteToggle.apply(...)`; `setVote`; on error emit `failure` keeping previous vote (no optimistic lock-in after error). Show SnackBar from `BlocListener` in the widget: `Nie udało się zapisać głosu`.

While `ConnectivityMixin` on `SpeakerDetails` has `connectivityResult == ConnectivityResult.none`, pass `enabled: false`.

Insert in `speaker_details.dart` after the role `SelectableText` block:

```dart
SpeakerVoteButtonsHost(speakerId: speaker.id ?? ''),
```

`SpeakerVoteButtonsHost` is a small `StatefulWidget` that creates the cubit via getIt (`getIt.get<SpeakerVoteCubit>(param1: speakerId)`), listens, and builds buttons. Only include the host when `speaker.id` is non-empty.

Run build_runner.

- [ ] **Step 4: Run tests**

```bash
flutter test test/features/speakers/presentation/widgets/speaker_vote_buttons_test.dart
flutter test test/features/engagement
```

Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add ng_poland_conf_app/lib/features/speakers ng_poland_conf_app/test/features/speakers
git commit -m "Add YouTube-style speaker votes on speaker details."
```

---

### Task 5: Contest CTA, banners, and win dialog on home

**Files:**
- Create: `ng_poland_conf_app/lib/features/home/datasources/data/contest_ui_local_datasource.dart`
- Create: `ng_poland_conf_app/lib/features/home/presentation/cubit/contest_home_state.dart`
- Create: `ng_poland_conf_app/lib/features/home/presentation/cubit/contest_home_cubit.dart`
- Create: `ng_poland_conf_app/lib/features/home/presentation/widgets/contest_home_section.dart`
- Modify: `ng_poland_conf_app/lib/features/home/presentation/home_page.dart`
- Modify: `ng_poland_conf_app/lib/main.dart` (open Hive box if needed)
- Test: `ng_poland_conf_app/test/features/engagement/domains/logic/engagement_logic_test.dart` (already covers view states)
- Test: `ng_poland_conf_app/test/features/home/presentation/widgets/contest_home_section_test.dart`

**Interfaces:**
- Consumes: `ContestHomeViewResolver`, `ContestRepository`, `EngagementConfigRepository`, `UserSessionCubit`, `ConferencesCubit`
- Produces: home section rendering `join` / `joined` / `winner` / `loser` / hidden; win dialog once per `confId` via Hive box `contest_ui`, key `winDialogShown_{confId}`

- [ ] **Step 1: Write the failing widget test**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/contest_home_view.dart';
import 'package:ng_poland_conf_app/features/home/presentation/widgets/contest_home_section.dart';

void main() {
  testWidgets('shows join button copy', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ContestHomeSection(
          view: ContestHomeView.join,
          online: true,
          onJoin: () {},
        ),
      ),
    );
    expect(find.text('Dołącz do konkursu'), findsOneWidget);
  });

  testWidgets('shows lose copy only for loser view', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ContestHomeSection(
          view: ContestHomeView.loser,
          online: true,
          onJoin: _noop,
        ),
      ),
    );
    expect(find.text('Niestety nie udało się, może innym razem'), findsOneWidget);
    expect(find.text('Dołącz do konkursu'), findsNothing);
  });

  testWidgets('winner banner uses spec copy', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ContestHomeSection(
          view: ContestHomeView.winner,
          online: true,
          onJoin: _noop,
        ),
      ),
    );
    expect(
      find.text('Wygrałeś nagrodę w konkursie. Odebrać możesz ją w strefie organizatorów.'),
      findsOneWidget,
    );
  });
}

void _noop() {}
```

- [ ] **Step 2: Run test to verify it fails**

```bash
flutter test test/features/home/presentation/widgets/contest_home_section_test.dart
```

Expected: FAIL — missing widget.

- [ ] **Step 3: Implement section, cubit, Hive flag, home wiring**

`ContestHomeSection` switch on `view`:
- `hidden` → `SizedBox.shrink()`
- `join` → enabled `FilledButton` `Dołącz do konkursu` (`onJoin` no-op if `!online`)
- `joined` → disabled button `Dołączono do konkursu`
- `winner` → banner with win body copy
- `loser` → banner with lose copy

`ContestUiLocalDataSource` using Hive box `contest_ui`:

```dart
@injectable
class ContestUiLocalDataSource {
  Future<Box<bool>> _box() => Hive.openBox<bool>('contest_ui');

  Future<bool> wasWinDialogShown(String confId) async {
    final box = await _box();
    return box.get('winDialogShown_$confId') ?? false;
  }

  Future<void> markWinDialogShown(String confId) async {
    final box = await _box();
    await box.put('winDialogShown_$confId', true);
  }
}
```

`ContestHomeCubit` (`@injectable`): watches selected conference, latest id, config, my participant, my winner. Emits `ContestHomeState(view:, latestConfId:, profile:)`.

`join()`:
- if unauthenticated, do not write; UI pushes login with `from` = home path
- if authenticated, `contestRepository.join(...)` with profile name/email; on failure emit error flag for SnackBar `Nie udało się dołączyć do konkursu`. Join is never automatic after login.

In `HomePage`, after the timer / before the schedule list, add `ContestHomeSectionHost`.

`BlocListener`: when `view == winner` and `wasWinDialogShown(confId) == false`, show `AlertDialog` title `Gratulacje!`, body win copy, button `OK` that marks shown. Do not show this dialog for losers.

Offline: `onJoin` disabled using existing `ConnectivityMixin` on `HomePage`.

- [ ] **Step 4: Run tests**

```bash
flutter test test/features/home/presentation/widgets/contest_home_section_test.dart
flutter test test/features/engagement/domains/logic/engagement_logic_test.dart
```

Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add ng_poland_conf_app/lib/features/home ng_poland_conf_app/lib/main.dart ng_poland_conf_app/test/features/home
git commit -m "Add contest join button, result banners, and win dialog on home."
```

---

### Task 6: Admin panel

**Files:**
- Replace stub: `ng_poland_conf_app/lib/features/admin/presentation/admin_page.dart`
- Create: `ng_poland_conf_app/lib/features/admin/presentation/cubit/admin_cubit.dart`
- Create: `ng_poland_conf_app/lib/features/admin/presentation/cubit/admin_state.dart`
- Create: `ng_poland_conf_app/lib/features/admin/presentation/widgets/admin_voting_section.dart`
- Create: `ng_poland_conf_app/lib/features/admin/presentation/widgets/admin_contest_section.dart`
- Modify: `ng_poland_conf_app/lib/widgets/custom_drawer.dart`
- Test: `ng_poland_conf_app/test/features/engagement/domains/logic/admin_ranking_test.dart`
- Test: `ng_poland_conf_app/test/features/admin/presentation/admin_drawer_test.dart`

**Interfaces:**
- Consumes: config/vote/contest repos, `GetAllSpeakersForConference`, `ContestDraw`, `LatestConferenceResolver`, `UserSessionCubit`
- Produces: admin page bound to **latest** `confId` only; ranking sorted by `up` desc, then `down` asc; draw N / draw 1; finish drawing

- [ ] **Step 1: Write failing tests**

`admin_ranking_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/speaker_vote_ranking.dart';

void main() {
  test('sorts by up desc then down asc', () {
    final ranked = SpeakerVoteRanking.sort([
      const SpeakerVoteRank(speakerId: 'a', name: 'A', up: 10, down: 5),
      const SpeakerVoteRank(speakerId: 'b', name: 'B', up: 10, down: 1),
      const SpeakerVoteRank(speakerId: 'c', name: 'C', up: 20, down: 0),
    ]);
    expect(ranked.map((e) => e.speakerId).toList(), ['c', 'b', 'a']);
  });
}
```

`admin_drawer_test.dart`: wrap `CustomDrawer` in `MaterialApp` with `UserSessionCubit` providing `authenticated` admin vs user. Need a testable seam: extract `bool showAdminEntry` is not enough because drawer reads GetIt.

To keep the test isolated, extract:

```dart
class AdminDrawerTile extends StatelessWidget {
  const AdminDrawerTile({super.key, required this.visible, required this.selected, required this.onTap});
  final bool visible;
  ...
}
```

Test:

```dart
testWidgets('hides admin tile when not visible', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: AdminDrawerTile(visible: false, selected: false, onTap: () {}),
      ),
    ),
  );
  expect(find.text('Admin'), findsNothing);
});

testWidgets('shows admin tile when visible', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: AdminDrawerTile(visible: true, selected: false, onTap: () {}),
      ),
    ),
  );
  expect(find.text('Admin'), findsOneWidget);
});
```

- [ ] **Step 2: Run tests to verify they fail**

```bash
flutter test test/features/engagement/domains/logic/admin_ranking_test.dart
flutter test test/features/admin/presentation/admin_drawer_test.dart
```

Expected: FAIL — missing types/widgets.

- [ ] **Step 3: Implement ranking helper, admin cubit, page, drawer tile**

`speaker_vote_ranking.dart`:

```dart
class SpeakerVoteRank {
  const SpeakerVoteRank({
    required this.speakerId,
    required this.name,
    required this.up,
    required this.down,
  });
  final String speakerId;
  final String name;
  final int up;
  final int down;
}

class SpeakerVoteRanking {
  const SpeakerVoteRanking._();

  static List<SpeakerVoteRank> sort(List<SpeakerVoteRank> input) {
    final copy = [...input];
    copy.sort((a, b) {
      final byUp = b.up.compareTo(a.up);
      if (byUp != 0) return byUp;
      return a.down.compareTo(b.down);
    });
    return copy;
  }
}
```

`AdminCubit` (`@injectable`):
- Resolve `latestConfId` from `ConferencesCubit` via `LatestConferenceResolver.fromConfIds(conferences.list.map((c) => c.confId))`.
- Load speakers with `GetAllSpeakersForConference(Params(confId: latestConfId, limit: 1000))` — always latest, not selected.
- Watch config, vote counts, participants, winners.
- `saveVoting({required bool enabled, required DateTime start, required DateTime end})`
- `saveContest({required bool enabled, required DateTime start, required DateTime end})` — if `enabled` and current status is `idle`, also set `contestStatus` to `open`.
- `draw({required int count, required Random random})`:
  1. `remaining = ContestDraw.pick(participantIds, winnerIds, count, random)`
  2. If empty: emit `message: 'Brak osób do wylosowania'` without changing status
  3. Else write winners with `order` starting at `currentWinners.length + 1`, copying `displayName`/`email` from participants (fallback `'brak danych'` if blank)
  4. If status is `idle` or `open`, `updateContestStatus(drawing)`
- `finishDrawing()`: only if status is `drawing`; set `finished`.

UI (`AdminPage` in `CustomScaffold`):
- AppBar title `Admin`, subtitle/chip of latest confId
- Voting section: `Switch` Włączone, two date-time fields (use `showDatePicker` + `showTimePicker` chained), ranked list `name` + `👍 $up  👎 $down`
- Contest section: switch, date-times, chip `status · N zgłoszeń`, `TextField` for N (default `1`), buttons `Losuj N` and `Losuj 1`, winners list `"$order. $displayName · $email"` (email or `brak danych`), `Zakończ losowanie` enabled iff `contestStatus == drawing`

If `UserSessionCubit` is not admin, page should not render content (router also redirects).

Drawer: `BlocBuilder<UserSessionCubit>` + `AdminDrawerTile(visible: state.isAdmin, ...)`. `onTap`: `context.go(AdminPage.path)` where `AdminPage.path = '/admin'`. Do **not** add Admin to the `Pages` enum.

Route already added in Task 2; point builder at the real `AdminPage`.

DateTimes stored in UTC in Firestore; pickers use local time and convert with `toUtc()`.

- [ ] **Step 4: Run tests**

```bash
flutter test test/features/engagement/domains/logic/admin_ranking_test.dart
flutter test test/features/admin/presentation/admin_drawer_test.dart
flutter test test/features/engagement/domains/logic/engagement_logic_test.dart
```

Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add ng_poland_conf_app/lib/features/admin ng_poland_conf_app/lib/features/engagement/domains/logic/speaker_vote_ranking.dart ng_poland_conf_app/lib/widgets/custom_drawer.dart ng_poland_conf_app/lib/routing/routing.dart ng_poland_conf_app/test
git commit -m "Add admin panel for vote stats, contest windows, and drawing."
```

---

### Task 7: Firestore rules

**Files:**
- Create: `firebase/firestore.rules`
- Create: `firebase/firestore.indexes.json` (empty indexes array if none needed)

**Interfaces:**
- Consumes: data model from Task 3
- Produces: deployable rules matching the spec

- [ ] **Step 1: Write rules file**

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    function signedIn() {
      return request.auth != null;
    }
    function isOwner(uid) {
      return signedIn() && request.auth.uid == uid;
    }
    function userDoc(uid) {
      return get(/databases/$(database)/documents/users/$(uid)).data;
    }
    function isAdmin() {
      return signedIn() && userDoc(request.auth.uid).role == 'admin';
    }

    match /users/{uid} {
      allow read: if isOwner(uid) || isAdmin();
      allow create: if isOwner(uid)
        && request.resource.data.role == 'user';
      allow update: if isOwner(uid)
        && request.resource.data.role == resource.data.role;
      allow delete: if false;
    }

    match /conf/{confId}/engagement/{docId} {
      allow read: if signedIn();
      allow write: if isAdmin() && docId == 'config';
    }

    match /conf/{confId}/speakerVotes/{speakerId}/votes/{uid} {
      allow read: if isOwner(uid) || isAdmin();
      allow create, update, delete: if isOwner(uid);
    }

    match /conf/{confId}/contestParticipants/{uid} {
      allow read: if isOwner(uid) || isAdmin();
      allow create: if isOwner(uid);
      allow update, delete: if false;
    }

    match /conf/{confId}/contestWinners/{uid} {
      allow read: if signedIn();
      allow write: if isAdmin();
    }
  }
}
```

Unsigned users cannot read `config`. Home contest button must work logged out, so **config read must be public**:

```
allow read: if true;
allow write: if isAdmin() && docId == 'config';
```

Winner docs: home banners for winners need read of `contestWinners/{uid}`. Logged-out users should not see win/lose (they cannot have joined). Spec: listen after login. Keep `allow read: if signedIn()` on winners. Own participant: owner or admin.

Unsigned users still need `engagement/config` to show/hide the join button. Use public read on config only.

- [ ] **Step 2: Sanity-check path names against datasources**

Open `engagement_config_remote_datasource.dart`, `speaker_vote_remote_datasource.dart`, `contest_remote_datasource.dart` and confirm collection names are exactly `engagement`, `speakerVotes`, `contestParticipants`, `contestWinners`, `users`.

- [ ] **Step 3: Document deploy**

Add a short note at the bottom of `docs/superpowers/specs/2026-08-20-voting-contest-admin-design.md`:

```
## Firestore paths (implementation)

- `conf/{confId}/engagement/config`
- `conf/{confId}/speakerVotes/{speakerId}/votes/{uid}`
- `conf/{confId}/contestParticipants/{uid}`
- `conf/{confId}/contestWinners/{uid}`
- `users/{uid}`

Deploy rules: `firebase deploy --only firestore:rules` from repo root (requires Firebase CLI and project `ngpolandconfapp`).
```

Do not run deploy in this task unless credentials are available. If CLI is logged in:

```bash
firebase deploy --only firestore:rules
```

- [ ] **Step 4: Run the full test suite**

```bash
cd ng_poland_conf_app && flutter test
```

Expected: PASS for all new tests.

- [ ] **Step 5: Commit**

```bash
git add firebase/firestore.rules firebase/firestore.indexes.json docs/superpowers/specs/2026-08-20-voting-contest-admin-design.md
git commit -m "Add Firestore security rules for voting and contest data."
```

---

## Manual smoke checklist (after Task 7)

1. Cold start logged out: home has no join button unless config is public-open for latest conf; speakers details hide thumbs outside window.
2. Set admin `role: admin` on your `users/{uid}` in console.
3. Admin drawer appears only on that account; `/admin` as non-admin redirects home.
4. Enable voting dates covering now → thumbs on latest speaker details; historical conf hides them. Toggle up/down/clear. Second device as another user does not see the first user's vote.
5. Enable contest window → join on home; after join, disabled “Dołączono”. First draw → join disappears; winner gets dialog + banner; others stay without lose copy until Finish; then lose banner only for non-winner participants.
6. Unauthenticated tap on join or thumb → auth → return; join/vote not auto-submitted.

---

## Spec coverage

| Spec requirement | Task |
|---|---|
| Optional global login | 2 (no global redirect) |
| `users/{uid}` create-if-missing, never admin | 2 |
| Admin drawer + `/admin` guard | 2, 6 |
| Latest numeric `confId` only | 1, 4, 5, 6 |
| Voting window + YouTube toggle + own vote only | 1, 3, 4 |
| Thumbs only on speaker details | 4 |
| Contest listen + join CTA | 3, 5 |
| Draw N / draw 1, first draw closes join | 1, 6 |
| Lose copy only after finish, participants only | 1, 5 |
| Win dialog + home banner | 5 |
| Admin ranking + date controls | 6 |
| Client Firestore, backend-ready repos | 3 |
| Rules | 7 |
| Event ratings unchanged | (no task touches them) |
