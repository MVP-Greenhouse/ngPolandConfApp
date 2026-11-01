# Guest Access / Optional Auth Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Allow guests to browse the app without login; expose Zaloguj/Wyloguj in the drawer; keep login required only for event voting (EventPage + Top 5).

**Architecture:** Soft GoRouter gate via a pure `authRedirect` helper (same style as `adminGuardRedirect`). Guests are never forced to `/auth`. Authenticated users hitting `/auth` still redirect to `from` or Home. Drawer shows Zaloguj / Wyloguj from `UserSessionCubit`. Vote/Top5 already push `AuthenticationPage.loginPath(from:)` — leave that path intact.

**Tech Stack:** Flutter 3.x, GoRouter, flutter_bloc, GetIt/injectable, Firebase Auth (sign-in/out only), `flutter_test`.

## Global Constraints

- Spec: `docs/superpowers/specs/2026-10-03-guest-access-optional-auth-design.md`
- Only voting requires login; Q&A and the rest stay open to guests
- Labels: **Zaloguj** / **Wyloguj** (Polish)
- No modal login; use existing `AuthenticationPage` (`/auth`)
- No auto-vote after returning from login
- No Firebase anonymous auth
- Admin guard unchanged (`adminGuardRedirect`)
- Work in `ng_poland_conf_app/`; tests: `cd ng_poland_conf_app && flutter test <path>`
- Existing WIP (event voting / Top 5) may be uncommitted — do not drop unrelated changes

## File structure

```
ng_poland_conf_app/lib/routing/routing.dart
  # extract authRedirect(...); soft-gate in GoRouter.redirect

ng_poland_conf_app/lib/widgets/custom_drawer.dart
  # AuthSessionDrawerTile (or private helper): Zaloguj / Wyloguj

ng_poland_conf_app/test/routing/auth_redirect_test.dart   # NEW
ng_poland_conf_app/test/widgets/auth_session_drawer_tile_test.dart  # NEW (or under test/widgets/)

# Vote / Top5: no production change expected (already needsLogin → loginPath)
```

---

### Task 1: Pure `authRedirect` + unit tests

**Files:**
- Modify: `ng_poland_conf_app/lib/routing/routing.dart` (add top-level function next to `adminGuardRedirect`)
- Create: `ng_poland_conf_app/test/routing/auth_redirect_test.dart`

**Interfaces:**
- Consumes: `AuthenticationPage.path`, `Pages.home.path`
- Produces:
  ```dart
  String? authRedirect({
    required String matchedLocation,
    required String? fullPath,
    required Map<String, String> queryParameters,
    required bool isAuthenticated,
  })
  ```
  - Guest (`isAuthenticated == false`): always `null` (no redirect), including when on `/auth`
  - Authenticated on `/auth` (matchedLocation or fullPath contains path): return decoded `from` if non-empty, else `Pages.home.path`
  - Authenticated elsewhere: `null`

- [ ] **Step 1: Write failing tests**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/authentication_page.dart';
import 'package:ng_poland_conf_app/routing/routing.dart';

void main() {
  test('guest can browse home without redirect', () {
    expect(
      authRedirect(
        matchedLocation: Pages.home.path,
        fullPath: Pages.home.path,
        queryParameters: const {},
        isAuthenticated: false,
      ),
      isNull,
    );
  });

  test('guest can browse schedule without redirect', () {
    expect(
      authRedirect(
        matchedLocation: Pages.schedule.path,
        fullPath: Pages.schedule.path,
        queryParameters: const {},
        isAuthenticated: false,
      ),
      isNull,
    );
  });

  test('guest on /auth stays (no redirect)', () {
    expect(
      authRedirect(
        matchedLocation: AuthenticationPage.path,
        fullPath: AuthenticationPage.path,
        queryParameters: const {},
        isAuthenticated: false,
      ),
      isNull,
    );
  });

  test('authenticated on /auth without from goes home', () {
    expect(
      authRedirect(
        matchedLocation: AuthenticationPage.path,
        fullPath: AuthenticationPage.path,
        queryParameters: const {},
        isAuthenticated: true,
      ),
      Pages.home.path,
    );
  });

  test('authenticated on /auth with from returns from', () {
    expect(
      authRedirect(
        matchedLocation: AuthenticationPage.path,
        fullPath: AuthenticationPage.path,
        queryParameters: const {'from': '/schedule/top5'},
        isAuthenticated: true,
      ),
      '/schedule/top5',
    );
  });

  test('authenticated on home has no redirect', () {
    expect(
      authRedirect(
        matchedLocation: Pages.home.path,
        fullPath: Pages.home.path,
        queryParameters: const {},
        isAuthenticated: true,
      ),
      isNull,
    );
  });
}
```

- [ ] **Step 2: Run tests — expect FAIL**

```bash
cd ng_poland_conf_app && flutter test test/routing/auth_redirect_test.dart
```

Expected: compilation/runtime fail — `authRedirect` not defined.

- [ ] **Step 3: Implement `authRedirect` in `routing.dart`**

Place next to `adminGuardRedirect`:

```dart
String? authRedirect({
  required String matchedLocation,
  required String? fullPath,
  required Map<String, String> queryParameters,
  required bool isAuthenticated,
}) {
  if (!isAuthenticated) {
    return null;
  }

  final onAuth = matchedLocation == AuthenticationPage.path ||
      (fullPath?.contains(AuthenticationPage.path) ?? false);
  if (!onAuth) {
    return null;
  }

  final from = queryParameters['from'];
  if (from != null && from.isNotEmpty) {
    return from;
  }
  return Pages.home.path;
}
```

- [ ] **Step 4: Run tests — expect PASS**

```bash
cd ng_poland_conf_app && flutter test test/routing/auth_redirect_test.dart
```

Expected: All tests pass.

- [ ] **Step 5: Commit** (only if user asked to commit / executing with commit approval)

```bash
git add ng_poland_conf_app/lib/routing/routing.dart \
  ng_poland_conf_app/test/routing/auth_redirect_test.dart \
  docs/superpowers/specs/2026-10-03-guest-access-optional-auth-design.md \
  docs/superpowers/plans/2026-10-03-guest-access-optional-auth.md
git commit -m "$(cat <<'EOF'
feat: add soft authRedirect for guest browsing

EOF
)"
```

---

### Task 2: Wire soft gate into GoRouter

**Files:**
- Modify: `ng_poland_conf_app/lib/routing/routing.dart` (`Routing()` redirect callback ~lines 67–89)

**Interfaces:**
- Consumes: `authRedirect`, `FirebaseAuth.instance.currentUser`, `adminGuardRedirect`
- Produces: GoRouter redirect that never sends guests to `/auth`

- [ ] **Step 1: Replace hard gate in `redirect`**

Replace the block that does `currentUser == null → AuthenticationPage.path` with:

```dart
redirect: (_, state) {
  if (state.matchedLocation.startsWith(AdminPage.path)) {
    return adminGuardRedirect(
      matchedLocation: state.matchedLocation,
      session: getIt.get<UserSessionCubit>().state,
    );
  }

  return authRedirect(
    matchedLocation: state.matchedLocation,
    fullPath: state.fullPath,
    queryParameters: state.uri.queryParameters,
    isAuthenticated: FirebaseAuth.instance.currentUser != null,
  );
},
```

Remove unused comments (`// return state.path;`) if present. Keep `import 'package:firebase_auth/firebase_auth.dart';` — still needed for `currentUser`.

- [ ] **Step 2: Analyze**

```bash
cd ng_poland_conf_app && dart analyze lib/routing/routing.dart
```

Expected: No issues.

- [ ] **Step 3: Re-run auth + admin redirect tests**

```bash
cd ng_poland_conf_app && flutter test test/routing/
```

Expected: All pass (`auth_redirect_test` + `admin_redirect_test`).

- [ ] **Step 4: Commit** (if approved)

```bash
git add ng_poland_conf_app/lib/routing/routing.dart
git commit -m "$(cat <<'EOF'
feat: allow guests past GoRouter auth wall

EOF
)"
```

---

### Task 3: Drawer Zaloguj / Wyloguj

**Files:**
- Modify: `ng_poland_conf_app/lib/widgets/custom_drawer.dart`
- Create: `ng_poland_conf_app/test/widgets/auth_session_drawer_tile_test.dart`

**Interfaces:**
- Consumes: `UserSessionCubit` / `UserSessionState`, `AuthenticationPage.loginPath`, `AuthenticationUtils.logout`, `GoRouterState`
- Produces: public (or library-visible) tile widget for tests:
  ```dart
  class AuthSessionDrawerTile extends StatelessWidget {
    const AuthSessionDrawerTile({
      super.key,
      required this.session,
      required this.onLogin,
      required this.onLogout,
    });
    final UserSessionState session;
    final VoidCallback onLogin;
    final VoidCallback onLogout;
  }
  ```
  - `loading` → `SizedBox.shrink()` (no tile)
  - `unauthenticated` → ListTile title `Zaloguj`, icon `Icons.login`, `onTap: onLogin`
  - `authenticated` → ListTile title `Wyloguj`, icon `Icons.logout`, `onTap: onLogout`

- [ ] **Step 1: Write failing widget tests**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_role.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/user_session_cubit.dart';
import 'package:ng_poland_conf_app/widgets/custom_drawer.dart';

void main() {
  const profile = UserProfile(
    uid: 'u1',
    displayName: 'Ada',
    email: 'ada@example.com',
    role: UserRole.user,
  );

  testWidgets('shows Zaloguj when unauthenticated', (tester) async {
    var login = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AuthSessionDrawerTile(
            session: const UserSessionState.unauthenticated(),
            onLogin: () => login = true,
            onLogout: () {},
          ),
        ),
      ),
    );

    expect(find.text('Zaloguj'), findsOneWidget);
    expect(find.text('Wyloguj'), findsNothing);
    await tester.tap(find.text('Zaloguj'));
    expect(login, isTrue);
  });

  testWidgets('shows Wyloguj when authenticated', (tester) async {
    var logout = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AuthSessionDrawerTile(
            session: const UserSessionState.authenticated(profile),
            onLogin: () {},
            onLogout: () => logout = true,
          ),
        ),
      ),
    );

    expect(find.text('Wyloguj'), findsOneWidget);
    await tester.tap(find.text('Wyloguj'));
    expect(logout, isTrue);
  });

  testWidgets('hides tile while loading', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AuthSessionDrawerTile(
            session: const UserSessionState.loading(),
            onLogin: () {},
            onLogout: () {},
          ),
        ),
      ),
    );

    expect(find.text('Zaloguj'), findsNothing);
    expect(find.text('Wyloguj'), findsNothing);
  });
}
```

- [ ] **Step 2: Run — expect FAIL**

```bash
cd ng_poland_conf_app && flutter test test/widgets/auth_session_drawer_tile_test.dart
```

Expected: `AuthSessionDrawerTile` not found.

- [ ] **Step 3: Implement `AuthSessionDrawerTile` and wire into `CustomDrawer`**

In `custom_drawer.dart`:

1. Add `AuthSessionDrawerTile` (match existing ListTile styling: rounded shape, leading icon width 34, `titleSmall` + primary color — same as `_buildLogoutButton`).
2. In `CustomDrawer` children, **before** the `Divider` (replace commented `// _buildLogoutButton(context)`):

```dart
BlocBuilder<UserSessionCubit, UserSessionState>(
  builder: (context, state) {
    return AuthSessionDrawerTile(
      session: state,
      onLogin: () {
        final from = GoRouterState.of(context).uri.toString();
        context.push(AuthenticationPage.loginPath(from: from));
      },
      onLogout: AuthenticationUtils.logout,
    );
  },
),
```

3. Add import for `AuthenticationPage`.
4. Remove dead `_buildLogoutButton` if fully superseded, **or** keep private and unused — prefer delete unused private method to avoid analyzer warnings.

- [ ] **Step 4: Run tile tests + analyze drawer**

```bash
cd ng_poland_conf_app && flutter test test/widgets/auth_session_drawer_tile_test.dart
cd ng_poland_conf_app && dart analyze lib/widgets/custom_drawer.dart
```

Expected: tests pass; no issues.

- [ ] **Step 5: Commit** (if approved)

```bash
git add ng_poland_conf_app/lib/widgets/custom_drawer.dart \
  ng_poland_conf_app/test/widgets/auth_session_drawer_tile_test.dart
git commit -m "$(cat <<'EOF'
feat: show Zaloguj/Wyloguj in drawer for guests and users

EOF
)"
```

---

### Task 4: Confirm vote / Top 5 login gate (no product change)

**Files:**
- Read/verify only unless broken:
  - `ng_poland_conf_app/lib/features/event/presentation/widgets/event_vote_button.dart`
  - `ng_poland_conf_app/lib/features/schedule/presentation/schedule_top5_page.dart`
  - `ng_poland_conf_app/lib/features/event/presentation/cubit/event_vote_cubit.dart`
  - `ng_poland_conf_app/lib/features/schedule/presentation/cubit/schedule_top5_cubit.dart`

**Interfaces:**
- Expected existing behavior (do not change unless missing):
  - Unauthenticated + voting open → show vote control
  - Tap → `context.push(AuthenticationPage.loginPath(from: GoRouterState.of(context).uri.toString()))`
  - No auto-toggle after return

- [ ] **Step 1: Grep for login push sites**

```bash
cd ng_poland_conf_app && rg -n "loginPath|needsLogin|requiresLogin" lib/features/event lib/features/schedule
```

Expected: Event vote button + Top 5 page both use `loginPath(from:)`.

- [ ] **Step 2: If either path missing `from` or missing push — fix minimally**

Only edit if broken. Otherwise no code change.

- [ ] **Step 3: Run related tests if present**

```bash
cd ng_poland_conf_app && flutter test test/features/event test/features/schedule 2>/dev/null || true
```

Also run the new auth tests:

```bash
cd ng_poland_conf_app && flutter test test/routing/ test/widgets/auth_session_drawer_tile_test.dart
```

Expected: pass (schedule/event suites may have unrelated failures from WIP — note them; do not expand scope).

- [ ] **Step 4: Commit only if Task 4 produced fixes**

---

### Task 5: Final verification

- [ ] **Step 1: Analyze touched files**

```bash
cd ng_poland_conf_app && dart analyze \
  lib/routing/routing.dart \
  lib/widgets/custom_drawer.dart
```

Expected: No issues.

- [ ] **Step 2: Run focused test suite**

```bash
cd ng_poland_conf_app && flutter test \
  test/routing/ \
  test/widgets/auth_session_drawer_tile_test.dart
```

Expected: All pass.

- [ ] **Step 3: Manual checklist (on device / emulator)**

- [ ] Cold start logged out → Home (not `/auth`)
- [ ] Drawer → Zaloguj → `/auth` → after login returns via `from`
- [ ] Drawer → Wyloguj when logged in
- [ ] Vote / Top 5 without session → login → back to screen
- [ ] `/admin` still blocked for non-admin / guest
- [ ] Q&A opens without login

---

## Spec coverage (self-review)

| Spec requirement | Task |
|---|---|
| Soft gate — guest browses | 1, 2 |
| `/auth` + `from` for logged-in | 1, 2 |
| Admin guard unchanged | 2 (admin branch first) |
| Drawer Zaloguj / Wyloguj | 3 |
| Hide tile while loading | 3 |
| Vote/Top5 login with `from` | 4 |
| No auto-vote | 4 (verify only) |
| Q&A open to guests | 2 + acceptance |
| Tests for redirect + drawer | 1, 3, 5 |

No placeholders left. Types consistent: `authRedirect(...)`, `AuthSessionDrawerTile`.
