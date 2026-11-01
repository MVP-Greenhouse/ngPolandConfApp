# Admin Hub and Dedicated Screens Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace admin ExpansionTile sections with a hub at `/admin` and dedicated screens at `/admin/voting` and `/admin/contest`, sharing one `AdminCubit`.

**Architecture:** Nested GoRouter under `/admin` with an `AdminShell` that owns the cubit lifecycle and provides it via `BlocProvider.value`. Hub lists two tiles with status subtitles; child pages reuse existing section widgets without outer ExpansionTiles. Admin guard and drawer selection use `startsWith('/admin')`.

**Tech Stack:** Flutter 3.x, GoRouter, flutter_bloc, GetIt/injectable, `flutter_test`.

## Global Constraints

- Spec: `docs/superpowers/specs/2026-09-05-admin-dedicated-screens-design.md`
- Do not change Firestore, contest draw/history domain, or `AdminCubit` business APIs (only UI/routing/lifecycle).
- Exact paths: `/admin`, `/admin/voting`, `/admin/contest`
- Exact titles: `Admin`, `Głosowanie`, `Konkurs`
- Hub subtitles: voting `włączone`/`wyłączone`; contest `{włączone|wyłączone} · {status.name} · {N} zgłoszeń`
- Keep one drawer entry `Admin` → hub
- Work in `ng_poland_conf_app/`; tests: `cd ng_poland_conf_app && flutter test <path>`
- Existing uncommitted local edits may exist in `routing.dart` / admin widgets — implement against current committed tree; do not silently drop unrelated user WIP without noting it

## File structure

```
ng_poland_conf_app/lib/features/admin/presentation/
  admin_shell.dart                 # NEW — cubit owner + nested Navigator
  admin_page.dart                  # hub only
  admin_voting_page.dart           # NEW
  admin_contest_page.dart          # NEW
  logic/admin_hub_status.dart      # NEW — subtitle helpers
  widgets/admin_voting_section.dart   # remove ExpansionTile
  widgets/admin_contest_section.dart  # remove ExpansionTile

ng_poland_conf_app/lib/routing/routing.dart
ng_poland_conf_app/lib/widgets/custom_drawer.dart

ng_poland_conf_app/test/features/admin/presentation/logic/admin_hub_status_test.dart
ng_poland_conf_app/test/features/admin/presentation/admin_hub_page_test.dart  # optional thin
# extend existing admin_guard / routing tests if present
```

---

### Task 1: Hub status helper (pure)

**Files:**
- Create: `ng_poland_conf_app/lib/features/admin/presentation/logic/admin_hub_status.dart`
- Test: `ng_poland_conf_app/test/features/admin/presentation/logic/admin_hub_status_test.dart`

**Interfaces:**
- Consumes: `EngagementConfig`, `ContestStatus`
- Produces:
  - `AdminHubStatus.votingSubtitle(EngagementConfig config) → String`
  - `AdminHubStatus.contestSubtitle({required EngagementConfig config, required int participantCount}) → String`

- [ ] **Step 1: Write failing tests**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/logic/admin_hub_status.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_status.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';

void main() {
  final base = EngagementConfig(
    votingEnabled: true,
    votingStartsAt: DateTime.utc(2026, 1, 1),
    votingEndsAt: DateTime.utc(2026, 1, 2),
    contestEnabled: true,
    contestStartsAt: DateTime.utc(2026, 1, 1),
    contestEndsAt: DateTime.utc(2026, 1, 2),
    contestStatus: ContestStatus.open,
  );

  test('voting subtitle on/off', () {
    expect(AdminHubStatus.votingSubtitle(base), 'włączone');
    expect(
      AdminHubStatus.votingSubtitle(base.copyWith(votingEnabled: false)),
      'wyłączone',
    );
  });

  test('contest subtitle format', () {
    expect(
      AdminHubStatus.contestSubtitle(config: base, participantCount: 12),
      'włączone · open · 12 zgłoszeń',
    );
    expect(
      AdminHubStatus.contestSubtitle(
        config: base.copyWith(
          contestEnabled: false,
          contestStatus: ContestStatus.finished,
        ),
        participantCount: 0,
      ),
      'wyłączone · finished · 0 zgłoszeń',
    );
  });
}
```

- [ ] **Step 2: Run — expect FAIL**

```bash
cd ng_poland_conf_app && flutter test test/features/admin/presentation/logic/admin_hub_status_test.dart
```

- [ ] **Step 3: Implement**

```dart
class AdminHubStatus {
  const AdminHubStatus._();

  static String votingSubtitle(EngagementConfig config) =>
      config.votingEnabled ? 'włączone' : 'wyłączone';

  static String contestSubtitle({
    required EngagementConfig config,
    required int participantCount,
  }) {
    final enabled = config.contestEnabled ? 'włączone' : 'wyłączone';
    return '$enabled · ${config.contestStatus.name} · $participantCount zgłoszeń';
  }
}
```

- [ ] **Step 4: Run — expect PASS**

- [ ] **Step 5: Commit**

```bash
git add ng_poland_conf_app/lib/features/admin/presentation/logic \
  ng_poland_conf_app/test/features/admin/presentation/logic
git commit -m "Add admin hub status subtitle helpers."
```

---

### Task 2: Flatten section widgets (no outer ExpansionTile)

**Files:**
- Modify: `ng_poland_conf_app/lib/features/admin/presentation/widgets/admin_voting_section.dart`
- Modify: `ng_poland_conf_app/lib/features/admin/presentation/widgets/admin_contest_section.dart`
- Modify tests that pump ExpansionTile titles if any (`admin_contest_widgets_test.dart`)

**Interfaces:**
- Same public constructors/callbacks as today
- Build method returns `Column` / `ListView`-friendly children (not ExpansionTile)
- Keep inner `AdminContestHistorySection` ExpansionTile

- [ ] **Step 1: Refactor voting section**

Replace `ExpansionTile(...)` with:

```dart
return Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    SwitchListTile(...),
    AdminDateTimeTile(...),
    AdminDateTimeTile(...),
    const SizedBox(height: 8),
    for (final rank in ranking) ListTile(...),
  ],
);
```

Remove unused title/subtitle from this widget (page AppBar owns the title).

- [ ] **Step 2: Refactor contest section** similarly — `Column` with name field, switch, dates, chip, draw controls, history section. No outer ExpansionTile.

- [ ] **Step 3: Fix widget tests** that expand tiles / look for ExpansionTile at section root.

```bash
cd ng_poland_conf_app && flutter test test/features/admin/
```

- [ ] **Step 4: Commit**

```bash
git add ng_poland_conf_app/lib/features/admin/presentation/widgets \
  ng_poland_conf_app/test/features/admin
git commit -m "Flatten admin voting and contest sections for dedicated screens."
```

---

### Task 3: Shell, hub, voting/contest pages, routing, drawer

**Files:**
- Create: `ng_poland_conf_app/lib/features/admin/presentation/admin_shell.dart`
- Rewrite: `ng_poland_conf_app/lib/features/admin/presentation/admin_page.dart` (hub)
- Create: `ng_poland_conf_app/lib/features/admin/presentation/admin_voting_page.dart`
- Create: `ng_poland_conf_app/lib/features/admin/presentation/admin_contest_page.dart`
- Modify: `ng_poland_conf_app/lib/routing/routing.dart`
- Modify: `ng_poland_conf_app/lib/widgets/custom_drawer.dart`
- Test: extend guard tests; add hub widget smoke test

**Interfaces:**
- `AdminPage.path = '/admin'`
- `AdminVotingPage.path = '/admin/voting'` (or relative child `voting`)
- `AdminContestPage.path = '/admin/contest'`
- `adminGuardRedirect`: `if (!matchedLocation.startsWith('/admin')) return null;`
- `AdminShell`: creates `AdminCubit` in `initState`, `dispose` closes it, `BlocProvider.value` + `child: child` from `ShellRoute` / nested builder

**GoRouter pattern (use ShellRoute or parent with children):**

```dart
GoRoute(
  path: '/admin',
  builder: (context, state) => AdminShell(
    child: const AdminPage(), // only used if no child — prefer ShellRoute
  ),
  routes: [
    GoRoute(
      path: 'voting',
      builder: (context, state) => const AdminVotingPage(),
    ),
    GoRoute(
      path: 'contest',
      builder: (context, state) => const AdminContestPage(),
    ),
  ],
),
```

Preferred: `ShellRoute` with `builder: (context, state, child) => AdminShell(child: child)` and hub as child route with path `/admin` empty child OR:

```dart
ShellRoute(
  builder: (context, state, child) => AdminShell(child: child),
  routes: [
    GoRoute(
      path: '/admin',
      builder: (_, __) => const AdminPage(),
      routes: [
        GoRoute(path: 'voting', builder: (_, __) => const AdminVotingPage()),
        GoRoute(path: 'contest', builder: (_, __) => const AdminContestPage()),
      ],
    ),
  ],
),
```

**AdminShell:**

```dart
class AdminShell extends StatefulWidget {
  const AdminShell({super.key, required this.child});
  final Widget child;
  @override
  State<AdminShell> createState() => _AdminShellState();
}

class _AdminShellState extends State<AdminShell> {
  late final AdminCubit _cubit;
  @override
  void initState() {
    super.initState();
    _cubit = getIt.get<AdminCubit>();
  }
  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _cubit, child: widget.child);
  }
}
```

**Important:** Today `AdminPage` creates and closes the cubit. Move that to the shell. Hub/voting/contest pages use `context.read<AdminCubit>()` / `BlocConsumer` **without** creating/closing.

**Hub page body:**

```dart
ListTile(
  title: const Text('Głosowanie'),
  subtitle: Text(AdminHubStatus.votingSubtitle(config)),
  onTap: () => context.go('/admin/voting'),
),
ListTile(
  title: const Text('Konkurs'),
  subtitle: Text(
    AdminHubStatus.contestSubtitle(
      config: config,
      participantCount: state.participants.length,
    ),
  ),
  onTap: () => context.go('/admin/contest'),
),
```

Keep AppBar chip + ConnectionStatus on hub. Child pages: AppBar title + `IconButton`/`BackButton` → `context.go('/admin')` (or `context.pop()` if stack push — prefer `go` for consistent shell).

**Redirect wiring:**

```dart
if (state.matchedLocation.startsWith(AdminPage.path)) {
  return adminGuardRedirect(
    matchedLocation: state.matchedLocation,
    session: getIt.get<UserSessionCubit>().state,
  );
}
```

**Drawer:**

```dart
final loc = GoRouterState.of(context).matchedLocation;
final isAdminRoute = loc.startsWith(AdminPage.path);
```

- [ ] **Step 1: Update `adminGuardRedirect` tests** (create if missing)

```dart
test('guards nested admin paths', () {
  expect(
    adminGuardRedirect(
      matchedLocation: '/admin/voting',
      session: /* non-admin */,
    ),
    Pages.home.path,
  );
});
```

- [ ] **Step 2: Implement shell + pages + routing + drawer**

- [ ] **Step 3: Run admin + any routing tests**

```bash
cd ng_poland_conf_app && flutter test test/features/admin/
```

- [ ] **Step 4: Commit**

```bash
git add ng_poland_conf_app/lib/features/admin \
  ng_poland_conf_app/lib/routing/routing.dart \
  ng_poland_conf_app/lib/widgets/custom_drawer.dart \
  ng_poland_conf_app/test/features/admin
git commit -m "Split admin into hub and dedicated voting/contest screens."
```

---

### Task 4: Hub widget smoke + regression

**Files:**
- Create: `ng_poland_conf_app/test/features/admin/presentation/admin_hub_page_test.dart`
- Run full admin suite

- [ ] **Step 1: Hub smoke test**

Pump `AdminPage` under `BlocProvider.value` with fake loaded `AdminState` (isAdmin, config, participants). Expect find text `Głosowanie` and `Konkurs` and subtitle from helper. Do **not** expect root `ExpansionTile` for those sections.

- [ ] **Step 2: Run**

```bash
cd ng_poland_conf_app && flutter test test/features/admin/ test/features/engagement/
```

Expected: all PASS.

- [ ] **Step 3: Commit**

```bash
git add ng_poland_conf_app/test/features/admin
git commit -m "Add admin hub smoke tests for dedicated screen entry points."
```

---

## Spec coverage

| Spec item | Task |
|---|---|
| Hub with status + confId chip | 1, 3 |
| `/admin/voting`, `/admin/contest` | 3 |
| Shared AdminCubit lifecycle | 3 |
| Guard startsWith `/admin` | 3 |
| Drawer selected for nested paths | 3 |
| Sections without outer ExpansionTile | 2 |
| History ExpansionTile kept | 2 |
| Helper + tests | 1, 4 |

## Plan self-review

- No Firestore/domain scope creep.
- Exact subtitle format locked in Task 1 tests.
- Cubit ownership moved once (shell) to avoid double-close.
