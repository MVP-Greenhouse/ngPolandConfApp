# Contest History, Multi-Round Contests, and Prizes Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add named contest rounds with archived winner history in admin, ability to start a new contest after finish (carry participants or fresh), and a drawer „Nagrody” screen for users who won at least once.

**Architecture:** Keep one active contest under existing `contestParticipants` / `contestWinners` + `engagement/config` (now with `contestName` / `contestId`). On finish, snapshot winners into `contestHistory/{contestId}`. Starting a new round clears winners (and optionally participants) only after archive succeeds. Home winner UI uses only active winners; historical wins surface via `/prizes`.

**Tech Stack:** Flutter 3.x, Cubit/BLoC, GetIt/injectable, GoRouter, Cloud Firestore, Hive (local win-dialog flags), `flutter_test`.

## Global Constraints

- Spec: `docs/superpowers/specs/2026-09-05-contest-history-prizes-design.md` (extends 2026-08-20 voting/contest design).
- Work in `ng_poland_conf_app/` unless editing `firebase/firestore.rules`.
- Contests remain latest-conference-only (highest numeric `confId`).
- Previous winners may join later rounds.
- Home: historical winner + open active contest → `join`/`joined` only (no win banner). Wins live in „Nagrody”.
- Archive before any clear/reset. Empty winners list is a valid archive.
- Exact copy:
  - Drawer / page title: `Nagrody`
  - Admin button: `Nowy konkurs`
  - Dialog switch label: `Przenieś uczestników`
  - Validation: `Podaj nazwę konkursu`
  - Wrong status: `Konkurs musi być zakończony`
- After injectable/freezed changes: `dart run build_runner build --delete-conflicting-outputs`
- Run tests: `cd ng_poland_conf_app && flutter test <path>`

## File structure

```
ng_poland_conf_app/lib/features/engagement/
  domains/entities/engagement_config.dart          # +contestName, contestId
  domains/entities/contest_history_entry.dart       # NEW
  domains/entities/user_prize.dart                  # NEW
  domains/logic/contest_archive.dart                # NEW — build history snapshot
  domains/logic/start_new_contest_guard.dart        # NEW — validate name/status
  domains/logic/user_prize_resolver.dart            # NEW — dedupe prizes list
  domains/logic/has_any_prize.dart                  # NEW — drawer visibility
  domains/repositories/contest_repository.dart      # +history/archive/start APIs
  datasources/data/engagement_mappers.dart
  datasources/data/contest_remote_datasource.dart
  datasources/repositories/contest_repository.dart

ng_poland_conf_app/lib/features/home/
  datasources/data/contest_ui_local_datasource.dart # key by contestId
  presentation/widgets/contest_home_section.dart    # pass contestId into dialog

ng_poland_conf_app/lib/features/admin/
  presentation/cubit/admin_cubit.dart / admin_state.dart
  presentation/widgets/admin_contest_section.dart
  presentation/widgets/admin_contest_history_section.dart  # NEW
  presentation/widgets/start_new_contest_dialog.dart       # NEW

ng_poland_conf_app/lib/features/prizes/             # NEW feature folder
  presentation/prizes_page.dart
  presentation/cubit/prizes_cubit.dart
  presentation/cubit/prizes_state.dart

ng_poland_conf_app/lib/routing/routing.dart
ng_poland_conf_app/lib/widgets/custom_drawer.dart
firebase/firestore.rules

ng_poland_conf_app/test/features/engagement/...
ng_poland_conf_app/test/features/prizes/...
```

Also update every `EngagementConfig(` construction in tests to still compile (defaults on new fields avoid mass edits).

---

### Task 1: Domain config fields + history/prize entities + pure logic

**Files:**
- Modify: `ng_poland_conf_app/lib/features/engagement/domains/entities/engagement_config.dart`
- Create: `ng_poland_conf_app/lib/features/engagement/domains/entities/contest_history_entry.dart`
- Create: `ng_poland_conf_app/lib/features/engagement/domains/entities/user_prize.dart`
- Create: `ng_poland_conf_app/lib/features/engagement/domains/logic/contest_archive.dart`
- Create: `ng_poland_conf_app/lib/features/engagement/domains/logic/start_new_contest_guard.dart`
- Create: `ng_poland_conf_app/lib/features/engagement/domains/logic/user_prize_resolver.dart`
- Create: `ng_poland_conf_app/lib/features/engagement/domains/logic/has_any_prize.dart`
- Test: `ng_poland_conf_app/test/features/engagement/domains/logic/contest_history_logic_test.dart`
- Modify: `ng_poland_conf_app/test/features/engagement/domains/logic/engagement_logic_test.dart` (add resolver cases)

**Interfaces:**
- Consumes: existing `ContestStatus`, `ContestWinner`, `EngagementConfig`, `ContestHomeViewResolver`
- Produces:
  - `EngagementConfig.contestName` / `contestId` (default `''`)
  - `ContestHistoryEntry({contestId, name, startsAt, endsAt, finishedAt, winners})`
  - `UserPrize({contestId, contestName, order, finishedAt})`
  - `ContestArchive.buildEntry(...)` → `ContestHistoryEntry`
  - `StartNewContestGuard.validate({status, name})` → `String?` error
  - `UserPrizeResolver.resolve(...)` → `List<UserPrize>`
  - `HasAnyPrize.resolve(...)` → `bool`

- [ ] **Step 1: Write failing tests**

Create `contest_history_logic_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_history_entry.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_status.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_winner.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/contest_archive.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/has_any_prize.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/start_new_contest_guard.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/user_prize_resolver.dart';

void main() {
  final winner = ContestWinner(
    uid: 'u1',
    displayName: 'Ada',
    email: 'a@b.c',
    order: 1,
  );

  group('StartNewContestGuard', () {
    test('requires finished status', () {
      expect(
        StartNewContestGuard.validate(
          status: ContestStatus.open,
          name: 'Koszulki',
        ),
        'Konkurs musi być zakończony',
      );
    });

    test('requires non-empty name', () {
      expect(
        StartNewContestGuard.validate(
          status: ContestStatus.finished,
          name: '  ',
        ),
        'Podaj nazwę konkursu',
      );
    });

    test('ok when finished and named', () {
      expect(
        StartNewContestGuard.validate(
          status: ContestStatus.finished,
          name: 'Koszulki',
        ),
        isNull,
      );
    });
  });

  group('ContestArchive', () {
    test('builds snapshot including empty winners', () {
      final entry = ContestArchive.buildEntry(
        contestId: 'c1',
        name: 'Runda 1',
        startsAt: DateTime.utc(2026, 1, 1),
        endsAt: DateTime.utc(2026, 1, 2),
        finishedAt: DateTime.utc(2026, 1, 3),
        winners: const [],
      );
      expect(entry.contestId, 'c1');
      expect(entry.winners, isEmpty);
    });
  });

  group('UserPrizeResolver', () {
    test('includes history wins', () {
      final history = [
        ContestHistoryEntry(
          contestId: 'c1',
          name: 'Koszulki',
          startsAt: DateTime.utc(2026, 1, 1),
          endsAt: DateTime.utc(2026, 1, 2),
          finishedAt: DateTime.utc(2026, 1, 3),
          winners: [winner],
        ),
      ];
      final prizes = UserPrizeResolver.resolve(
        uid: 'u1',
        history: history,
        activeWin: null,
        activeContestId: 'c2',
        activeContestName: 'Gadżety',
      );
      expect(prizes.single.contestId, 'c1');
      expect(prizes.single.contestName, 'Koszulki');
      expect(prizes.single.order, 1);
    });

    test('adds active win only when contestId not in history', () {
      final prizes = UserPrizeResolver.resolve(
        uid: 'u1',
        history: const [],
        activeWin: winner,
        activeContestId: 'c2',
        activeContestName: 'Gadżety',
      );
      expect(prizes.single.contestId, 'c2');
    });

    test('dedupes active win when already archived', () {
      final history = [
        ContestHistoryEntry(
          contestId: 'c2',
          name: 'Gadżety',
          startsAt: DateTime.utc(2026, 1, 1),
          endsAt: DateTime.utc(2026, 1, 2),
          finishedAt: DateTime.utc(2026, 1, 3),
          winners: [winner],
        ),
      ];
      final prizes = UserPrizeResolver.resolve(
        uid: 'u1',
        history: history,
        activeWin: winner,
        activeContestId: 'c2',
        activeContestName: 'Gadżety',
      );
      expect(prizes, hasLength(1));
    });
  });

  group('HasAnyPrize', () {
    test('true for history or active', () {
      expect(
        HasAnyPrize.resolve(historyWins: 0, hasActiveWin: true),
        isTrue,
      );
      expect(
        HasAnyPrize.resolve(historyWins: 1, hasActiveWin: false),
        isTrue,
      );
      expect(
        HasAnyPrize.resolve(historyWins: 0, hasActiveWin: false),
        isFalse,
      );
    });
  });
}
```

Add to `engagement_logic_test.dart` inside `ContestHomeViewResolver` group:

```dart
test('historical winner with open contest sees join, not winner', () {
  expect(
    ContestHomeViewResolver.resolve(
      isLatestConference: true,
      config: openConfig,
      now: now,
      isParticipant: false,
      isWinner: false, // active winners only
    ),
    ContestHomeView.join,
  );
});

test('active winner still winner even if they also have history', () {
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
```

- [ ] **Step 2: Run tests — expect FAIL**

```bash
cd ng_poland_conf_app && flutter test test/features/engagement/domains/logic/contest_history_logic_test.dart
```

Expected: FAIL (missing libraries / types).

- [ ] **Step 3: Implement entities + logic**

`engagement_config.dart` — add defaults so existing call sites compile:

```dart
final String contestName;
final String contestId;

const EngagementConfig({
  // existing required fields...
  this.contestName = '',
  this.contestId = '',
});

// missing: contestName: '', contestId: ''
// copyWith: include contestName, contestId
```

`contest_history_entry.dart`:

```dart
class ContestHistoryEntry {
  const ContestHistoryEntry({
    required this.contestId,
    required this.name,
    required this.startsAt,
    required this.endsAt,
    required this.finishedAt,
    required this.winners,
  });
  final String contestId;
  final String name;
  final DateTime startsAt;
  final DateTime endsAt;
  final DateTime finishedAt;
  final List<ContestWinner> winners;
}
```

`user_prize.dart`:

```dart
class UserPrize {
  const UserPrize({
    required this.contestId,
    required this.contestName,
    required this.order,
    this.finishedAt,
  });
  final String contestId;
  final String contestName;
  final int order;
  final DateTime? finishedAt;
}
```

`start_new_contest_guard.dart`:

```dart
class StartNewContestGuard {
  const StartNewContestGuard._();
  static String? validate({
    required ContestStatus status,
    required String name,
  }) {
    if (status != ContestStatus.finished) {
      return 'Konkurs musi być zakończony';
    }
    if (name.trim().isEmpty) return 'Podaj nazwę konkursu';
    return null;
  }
}
```

`contest_archive.dart`:

```dart
class ContestArchive {
  const ContestArchive._();
  static ContestHistoryEntry buildEntry({
    required String contestId,
    required String name,
    required DateTime startsAt,
    required DateTime endsAt,
    required DateTime finishedAt,
    required List<ContestWinner> winners,
  }) {
    return ContestHistoryEntry(
      contestId: contestId,
      name: name,
      startsAt: startsAt,
      endsAt: endsAt,
      finishedAt: finishedAt,
      winners: List.unmodifiable(winners),
    );
  }
}
```

`user_prize_resolver.dart`:

```dart
class UserPrizeResolver {
  const UserPrizeResolver._();
  static List<UserPrize> resolve({
    required String uid,
    required List<ContestHistoryEntry> history,
    required ContestWinner? activeWin,
    required String? activeContestId,
    required String activeContestName,
  }) {
    final prizes = <UserPrize>[];
    final seen = <String>{};
    for (final entry in history) {
      ContestWinner? mine;
      for (final w in entry.winners) {
        if (w.uid == uid) {
          mine = w;
          break;
        }
      }
      if (mine == null) continue;
      seen.add(entry.contestId);
      prizes.add(
        UserPrize(
          contestId: entry.contestId,
          contestName: entry.name,
          order: mine.order,
          finishedAt: entry.finishedAt,
        ),
      );
    }
    final activeId = activeContestId;
    if (activeWin != null &&
        activeId != null &&
        activeId.isNotEmpty &&
        !seen.contains(activeId)) {
      prizes.add(
        UserPrize(
          contestId: activeId,
          contestName: activeContestName,
          order: activeWin.order,
        ),
      );
    }
    prizes.sort((a, b) {
      final af = a.finishedAt;
      final bf = b.finishedAt;
      if (af == null && bf == null) return 0;
      if (af == null) return -1;
      if (bf == null) return 1;
      return bf.compareTo(af);
    });
    return prizes;
  }
}
```

`has_any_prize.dart`:

```dart
class HasAnyPrize {
  const HasAnyPrize._();
  static bool resolve({
    required int historyWins,
    required bool hasActiveWin,
  }) =>
      historyWins > 0 || hasActiveWin;
}
```

- [ ] **Step 4: Run tests — expect PASS**

```bash
cd ng_poland_conf_app && flutter test test/features/engagement/domains/logic/contest_history_logic_test.dart test/features/engagement/domains/logic/engagement_logic_test.dart
```

- [ ] **Step 5: Commit**

```bash
git add ng_poland_conf_app/lib/features/engagement/domains \
  ng_poland_conf_app/test/features/engagement/domains/logic
git commit -m "Add contest history domain entities and prize resolution logic."
```

---

### Task 2: Mappers + Firestore datasource/repository APIs

**Files:**
- Modify: `ng_poland_conf_app/lib/features/engagement/datasources/data/engagement_mappers.dart`
- Modify: `ng_poland_conf_app/lib/features/engagement/domains/repositories/contest_repository.dart`
- Modify: `ng_poland_conf_app/lib/features/engagement/datasources/data/contest_remote_datasource.dart`
- Modify: `ng_poland_conf_app/lib/features/engagement/datasources/repositories/contest_repository.dart`
- Modify: `ng_poland_conf_app/test/features/engagement/datasources/engagement_mappers_test.dart`

**Interfaces:**
- Consumes: Task 1 entities
- Produces repository methods:
  - `Stream<List<ContestHistoryEntry>> watchHistory(String confId)`
  - `Future<void> archiveContestIfAbsent({required String confId, required ContestHistoryEntry entry})`
  - `Future<void> clearWinners(String confId)`
  - `Future<void> clearParticipants(String confId)`
  - `Future<void> startNewContest({required String confId, required EngagementConfig nextConfig, required bool carryParticipants})`  
    Implementation order inside datasource: ensure archive already done by caller → clear winners → maybe clear participants → save config (`nextConfig` already has new id/name/status `open`).

- [ ] **Step 1: Extend mapper tests**

```dart
test('config maps contestName and contestId', () {
  final config = EngagementMappers.configFromMap({
    // existing keys...
    'contestName': 'Koszulki',
    'contestId': 'abc',
  });
  expect(config.contestName, 'Koszulki');
  expect(config.contestId, 'abc');
  final map = EngagementMappers.configToMap(config);
  expect(map['contestName'], 'Koszulki');
  expect(map['contestId'], 'abc');
});

test('history entry from map', () {
  final entry = EngagementMappers.historyFromMap('c1', {
    'name': 'Koszulki',
    'startsAt': DateTime.utc(2026, 1, 1),
    'endsAt': DateTime.utc(2026, 1, 2),
    'finishedAt': DateTime.utc(2026, 1, 3),
    'winners': [
      {
        'uid': 'u1',
        'displayName': 'Ada',
        'email': 'a@b.c',
        'order': 1,
      },
    ],
  });
  expect(entry?.name, 'Koszulki');
  expect(entry?.winners.single.uid, 'u1');
});
```

- [ ] **Step 2: Run mapper test — expect FAIL**

```bash
cd ng_poland_conf_app && flutter test test/features/engagement/datasources/engagement_mappers_test.dart
```

- [ ] **Step 3: Implement mappers + datasource + repo**

Update `configFromMap` / `configToMap` for `contestName` / `contestId`.

Add:

```dart
static ContestHistoryEntry? historyFromMap(
  String contestId,
  Map<String, dynamic>? data,
) {
  if (data == null) return null;
  final rawWinners = data['winners'];
  final winners = <ContestWinner>[];
  if (rawWinners is List) {
    for (final item in rawWinners) {
      if (item is! Map) continue;
      final map = Map<String, dynamic>.from(item);
      final uid = map['uid'] as String? ?? '';
      if (uid.isEmpty) continue;
      final w = winnerFromMap(uid, map);
      if (w != null) winners.add(w);
    }
  }
  return ContestHistoryEntry(
    contestId: contestId,
    name: data['name'] as String? ?? '',
    startsAt: _dateTime(data['startsAt']),
    endsAt: _dateTime(data['endsAt']),
    finishedAt: _dateTime(data['finishedAt']),
    winners: winners,
  );
}

static Map<String, dynamic> historyToMap(ContestHistoryEntry entry) {
  return {
    'name': entry.name,
    'startsAt': entry.startsAt,
    'endsAt': entry.endsAt,
    'finishedAt': entry.finishedAt,
    'winners': [
      for (final w in entry.winners)
        {
          'uid': w.uid,
          'displayName': w.displayName,
          'email': w.email,
          'order': w.order,
        },
    ],
  };
}
```

Datasource additions (paths):

```dart
CollectionReference<Map<String, dynamic>> _historyCollection(String confId) =>
    _firestore.collection('conf').doc(confId).collection('contestHistory');
```

- `watchHistory`: snapshots → map docs → sort by `finishedAt` desc  
- `archiveContestIfAbsent`: `final ref = _historyCollection(confId).doc(entry.contestId);` if `(await ref.get()).exists` return; else `ref.set(historyToMap(entry))`  
- `clearWinners` / `clearParticipants`: batched deletes (chunks of 400)  
- `startNewContest`: `clearWinners`; if `!carryParticipants` then `clearParticipants`; then write config via existing config set (call engagement config save from cubit **or** set config fields on `_configRef` here). Prefer cubit calling: archive → clearWinners → clearParticipants? → `_configRepository.saveConfig`. Then repository does not need a combined `startNewContest` — instead expose `clearWinners` + `clearParticipants` + `archiveContestIfAbsent` + `watchHistory`.

**Lock interface to:**

```dart
Stream<List<ContestHistoryEntry>> watchHistory(String confId);
Future<void> archiveContestIfAbsent({
  required String confId,
  required ContestHistoryEntry entry,
});
Future<void> clearWinners(String confId);
Future<void> clearParticipants(String confId);
```

Cubit orchestrates start-new order.

- [ ] **Step 4: Run mapper tests — PASS; run build_runner if needed**

```bash
cd ng_poland_conf_app && flutter test test/features/engagement/datasources/engagement_mappers_test.dart
```

- [ ] **Step 5: Commit**

```bash
git add ng_poland_conf_app/lib/features/engagement \
  ng_poland_conf_app/test/features/engagement/datasources
git commit -m "Add contest history Firestore mapping and clear/archive APIs."
```

---

### Task 3: Win dialog keyed by `contestId`

**Files:**
- Modify: `ng_poland_conf_app/lib/features/home/datasources/data/contest_ui_local_datasource.dart`
- Modify: `ng_poland_conf_app/lib/features/home/presentation/widgets/contest_home_section.dart`
- Modify: `ng_poland_conf_app/lib/features/home/presentation/cubit/contest_home_cubit.dart` (expose `contestId` on state if missing)
- Modify: `ng_poland_conf_app/lib/features/home/presentation/cubit/contest_home_state.dart`
- Test: update any home cubit tests constructing state

**Interfaces:**
- Consumes: `config.contestId`
- Produces: Hive keys `winDialogShown_${contestId}`; listener uses `contestId` not `confId`

- [ ] **Step 1: Change local datasource API**

```dart
Future<bool> wasWinDialogShown(String contestId) async {
  final box = await _box();
  return box.get('winDialogShown_$contestId') ?? false;
}

Future<void> markWinDialogShown(String contestId) async {
  final box = await _box();
  await box.put('winDialogShown_$contestId', true);
}
```

- [ ] **Step 2: Wire contestId through ContestWinDialogListener**

Replace `confId` prop with `contestId` (nullable). Skip dialog when `contestId == null || contestId.isEmpty`.

Ensure `ContestHomeState` includes `contestId` from `config.contestId` (or pass `state.config`-equivalent from cubit). Today state has `latestConfId` — add `String? contestId`.

- [ ] **Step 3: Run home-related tests**

```bash
cd ng_poland_conf_app && flutter test test/features/home/
```

- [ ] **Step 4: Commit**

```bash
git add ng_poland_conf_app/lib/features/home ng_poland_conf_app/test/features/home
git commit -m "Key contest win dialog to contestId instead of confId."
```

---

### Task 4: Admin — name, archive on finish, history UI, start new contest

**Files:**
- Modify: `ng_poland_conf_app/lib/features/admin/presentation/cubit/admin_state.dart` (+ `List<ContestHistoryEntry> history`)
- Modify: `ng_poland_conf_app/lib/features/admin/presentation/cubit/admin_cubit.dart`
- Modify: `ng_poland_conf_app/lib/features/admin/presentation/widgets/admin_contest_section.dart`
- Create: `ng_poland_conf_app/lib/features/admin/presentation/widgets/admin_contest_history_section.dart`
- Create: `ng_poland_conf_app/lib/features/admin/presentation/widgets/start_new_contest_dialog.dart`
- Modify: `ng_poland_conf_app/lib/features/admin/presentation/admin_page.dart`
- Modify: `ng_poland_conf_app/test/features/admin/presentation/cubit/admin_cubit_test.dart`
- Run: `dart run build_runner build --delete-conflicting-outputs`

**Interfaces:**
- Consumes: Task 1–2 APIs
- Produces cubit methods:
  - `saveContest({enabled, start, end, name})` — when enabling `idle→open`, require trimmed name; generate `contestId` via `const Uuid().v4()` **or** `FirebaseFirestore`-free `DateTime.now().microsecondsSinceEpoch.toString()` if uuid package absent — prefer existing deps: check `pubspec.yaml`; if no uuid, use `'c_${DateTime.now().toUtc().millisecondsSinceEpoch}'`.
  - `finishDrawing()` — archive then set finished
  - `startNewContest({required String name, required bool carryParticipants})`

- [ ] **Step 1: Write/adjust admin cubit tests for finish archive + start new**

Fake `ContestRepository` must implement new methods. Add tests:

```dart
test('finishDrawing archives then marks finished', () async { ... });
test('startNewContest carry keeps participants clears winners', () async { ... });
test('startNewContest without carry clears both', () async { ... });
test('startNewContest rejects when not finished', () async { ... });
test('saveContest idle to open requires name', () async { ... });
```

- [ ] **Step 2: Run — expect FAIL**

```bash
cd ng_poland_conf_app && flutter test test/features/admin/presentation/cubit/admin_cubit_test.dart
```

- [ ] **Step 3: Implement cubit orchestration**

`finishDrawing`:

```dart
Future<void> finishDrawing() async {
  final confId = state.latestConfId;
  final config = state.config;
  if (confId == null || config == null) return;
  if (config.contestStatus != ContestStatus.drawing) return;

  var contestId = config.contestId;
  if (contestId.isEmpty) {
    contestId = 'c_${DateTime.now().toUtc().millisecondsSinceEpoch}';
    await _configRepository.saveConfig(
      confId,
      config.copyWith(contestId: contestId),
    );
  }

  final entry = ContestArchive.buildEntry(
    contestId: contestId,
    name: config.contestName.isEmpty ? 'Konkurs' : config.contestName,
    startsAt: config.contestStartsAt,
    endsAt: config.contestEndsAt,
    finishedAt: DateTime.now().toUtc(),
    winners: state.winners,
  );
  await _contestRepository.archiveContestIfAbsent(
    confId: confId,
    entry: entry,
  );
  await _contestRepository.updateContestStatus(
    confId: confId,
    status: ContestStatus.finished,
  );
  _emitContestStatus(ContestStatus.finished);
}
```

`startNewContest`:

```dart
Future<void> startNewContest({
  required String name,
  required bool carryParticipants,
}) async {
  final confId = state.latestConfId;
  final config = state.config;
  if (confId == null || config == null) return;
  final error = StartNewContestGuard.validate(
    status: config.contestStatus,
    name: name,
  );
  if (error != null) {
    emit(state.copyWith(message: error));
    return;
  }

  // Ensure archive exists for current id (idempotent).
  if (config.contestId.isNotEmpty) {
    await _contestRepository.archiveContestIfAbsent(
      confId: confId,
      entry: ContestArchive.buildEntry(
        contestId: config.contestId,
        name: config.contestName.isEmpty ? 'Konkurs' : config.contestName,
        startsAt: config.contestStartsAt,
        endsAt: config.contestEndsAt,
        finishedAt: DateTime.now().toUtc(),
        winners: state.winners,
      ),
    );
  }

  await _contestRepository.clearWinners(confId);
  if (!carryParticipants) {
    await _contestRepository.clearParticipants(confId);
  }

  final nextId = 'c_${DateTime.now().toUtc().millisecondsSinceEpoch}';
  final next = config.copyWith(
    contestId: nextId,
    contestName: name.trim(),
    contestStatus: ContestStatus.open,
    contestEnabled: true,
  );
  await _configRepository.saveConfig(confId, next);
}
```

`saveContest`: add `required String name` (or optional with validation only on idle→open). When `enabled && status==idle`, if `name.trim().isEmpty` emit message and return; else set `contestName`, generate `contestId` if empty, status `open`.

Watch `watchHistory(confId)` in `_mapToState` Combine and put into `AdminState.history`.

- [ ] **Step 4: UI**

`admin_contest_section.dart`:
- TextField for contest name (bound via callback `onNameChanged` / save on enable).
- When `status == finished`, show `FilledButton` „Nowy konkurs” → `showDialog` `StartNewContestDialog`.
- Include `AdminContestHistorySection(history: ...)`.

`start_new_contest_dialog.dart`: name field + SwitchListTile „Przenieś uczestników“ (default false) + confirm.

`admin_contest_history_section.dart`: `ExpansionTile` „Historia“, initially collapsed; each past contest nested tile with winners list.

- [ ] **Step 5: build_runner + tests PASS**

```bash
cd ng_poland_conf_app && dart run build_runner build --delete-conflicting-outputs
cd ng_poland_conf_app && flutter test test/features/admin/
```

- [ ] **Step 6: Commit**

```bash
git add ng_poland_conf_app/lib/features/admin ng_poland_conf_app/test/features/admin
git commit -m "Add admin contest naming, history, and start-new-contest flow."
```

---

### Task 5: Prizes page, drawer tile, routing guard

**Files:**
- Create: `ng_poland_conf_app/lib/features/prizes/presentation/prizes_page.dart`
- Create: `ng_poland_conf_app/lib/features/prizes/presentation/cubit/prizes_cubit.dart`
- Create: `ng_poland_conf_app/lib/features/prizes/presentation/cubit/prizes_state.dart`
- Modify: `ng_poland_conf_app/lib/routing/routing.dart`
- Modify: `ng_poland_conf_app/lib/widgets/custom_drawer.dart`
- Test: `ng_poland_conf_app/test/features/prizes/presentation/cubit/prizes_cubit_test.dart` (optional thin) **and** unit already covers resolver
- Run build_runner for freezed cubit

**Interfaces:**
- Consumes: `ContestRepository.watchHistory`, `watchMyWin`, `EngagementConfigRepository.watchConfig`, `UserSessionCubit`, `ConferencesCubit` (latest conf id), `UserPrizeResolver`, `HasAnyPrize`
- Produces: `PrizesPage.path = '/prizes'`; drawer tile visible when `state.hasPrizes`

- [ ] **Step 1: Implement PrizesCubit**

Freezed state:

```dart
@freezed
abstract class PrizesState with _$PrizesState {
  const factory PrizesState({
    @Default(false) bool hasPrizes,
    @Default(<UserPrize>[]) List<UserPrize> prizes,
    @Default(true) bool loading,
  }) = _PrizesState;
}
```

Combine streams for latest conf + uid; if logged out → empty; else resolve prizes and `hasPrizes`.

- [ ] **Step 2: PrizesPage**

`CustomScaffold` + AppBar title `Nagrody` + `ListView` of prizes (`contestName`, subtitle `Miejsce ${order}` / date).

- [ ] **Step 3: Routing**

```dart
String? prizesGuardRedirect({
  required String matchedLocation,
  required UserSessionState session,
  required bool hasPrizes,
}) {
  if (matchedLocation != PrizesPage.path) return null;
  if (session.maybeWhen(loading: () => true, orElse: () => false)) {
    return null;
  }
  final loggedIn = session.maybeWhen(
    authenticated: (_) => true,
    orElse: () => false,
  );
  if (!loggedIn || !hasPrizes) return Pages.home.path;
  return null;
}
```

Register `GoRoute` for `/prizes`. In redirect, call prizes guard (cubit/getIt for hasPrizes — mirror admin pattern; if awkward, guard only login and let page show empty / redirect in page `initState`).

**Preferred:** page listens to cubit; if `!loading && !hasPrizes` → `context.go(Pages.home.path)`. Drawer hides tile when `!hasPrizes`.

- [ ] **Step 4: Drawer**

Next to `AdminDrawerTile`, add `PrizesDrawerTile` driven by `BlocBuilder<PrizesCubit, PrizesState>` (provide cubit at app level **or** getIt factory watched via nested BlocProvider in drawer). Follow Admin pattern: `getIt.get<PrizesCubit>()` as singleton/lazy singleton that lives for app session.

Register `@lazySingleton` PrizesCubit (or `@injectable` + provide higher up). Prefer `@lazySingleton` so drawer and route share state.

- [ ] **Step 5: build_runner + test smoke**

```bash
cd ng_poland_conf_app && dart run build_runner build --delete-conflicting-outputs
cd ng_poland_conf_app && flutter test test/features/engagement/domains/logic/contest_history_logic_test.dart
```

- [ ] **Step 6: Commit**

```bash
git add ng_poland_conf_app/lib/features/prizes \
  ng_poland_conf_app/lib/routing/routing.dart \
  ng_poland_conf_app/lib/widgets/custom_drawer.dart \
  ng_poland_conf_app/lib/injectable.config.dart \
  ng_poland_conf_app/test/features/prizes
git commit -m "Add Nagrody drawer section and prizes page for contest winners."
```

---

### Task 6: Firestore rules + regression suite

**Files:**
- Modify: `firebase/firestore.rules`
- Optionally document deploy note in spec (already exists)

**Rules changes (required for clearParticipants):**

```javascript
match /conf/{confId}/contestParticipants/{uid} {
  allow read: if isOwner(uid) || isAdmin();
  allow create: if isOwner(uid);
  allow update: if false;
  allow delete: if isAdmin();
}

match /conf/{confId}/contestWinners/{uid} {
  allow read: if signedIn();
  allow write: if isAdmin();
}

match /conf/{confId}/contestHistory/{contestId} {
  allow read: if signedIn();
  allow create, update: if isAdmin();
  allow delete: if false;
}
```

- [ ] **Step 1: Apply rules file edits**

- [ ] **Step 2: Run full related tests**

```bash
cd ng_poland_conf_app && flutter test test/features/engagement test/features/admin test/features/home test/features/prizes
```

Expected: all PASS.

- [ ] **Step 3: Commit**

```bash
git add firebase/firestore.rules
git commit -m "Allow admin contest resets and protect contestHistory in Firestore rules."
```

---

## Spec coverage checklist

| Spec requirement | Task |
|---|---|
| `contestName` / `contestId` on config | 1, 2, 4 |
| `contestHistory` snapshot on finish (incl. 0 winners) | 1, 2, 4 |
| Admin history UI | 4 |
| Nowy konkurs + carry/fresh | 1, 4 |
| Archive before clear | 4 |
| Home winner only from active winners | 1 (tests), existing resolver |
| Win dialog per `contestId` | 3 |
| Nagrody drawer + `/prizes` | 5 |
| Rules for history + admin delete participants | 6 |
| Previous winners may rejoin | no code change (eligibility unchanged) |

## Plan self-review notes

- No TBD placeholders left for required APIs.
- `startNewContest` orchestration lives in cubit (not a single repo mega-method) to keep archive-then-clear explicit.
- Participant `delete` rule gap from v1 is explicitly fixed in Task 6 — without it carry/fresh cannot work.
