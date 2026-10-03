# Dostęp gościa i opcjonalne logowanie

Data: 2026-10-03  
Status: zatwierdzony design (soft auth gate)  
Podejście: **1 — soft gate w GoRouterze**

## Cel

Aplikacja ma być używalna **bez logowania**. Gość przegląda treść konferencji. Logowanie jest:

1. dostępne z **drawera** (Zaloguj / Wyloguj),
2. wymagane **tylko przy głosowaniu** na event (EventPage + Ranking Top 5).

## Decyzje produktowe (z brainstormingu)

| Temat | Decyzja |
|---|---|
| Gdzie „Zaloguj” | Drawer (dół listy nawigacji) |
| Po zalogowaniu w drawerze | Ten sam slot → **Wyloguj** |
| Co wymaga loginu | Tylko głosowanie (event + Top 5) |
| Q&A / reszta | Gość bez logowania |
| Sposób logowania | Pełna `AuthenticationPage` (`/auth`), nie modal |
| Po głosowaniu bez sesji | Od razu `/auth?from=…` (bez osobnego dialogu) |
| Firebase anon | Nie (v1) |

## Poza zakresem (v1)

- Login jako modal / bottom sheet.
- Anonimowa sesja Firebase + upgrade konta.
- Wymaganie loginu dla Q&A, ratingów gwiazdkowych ani innych akcji.
- Profil użytkownika / e-mail w drawerze.
- Zmiana reguł Firestore (osobny ticket, jeśli reguły blokują odczyt gościom).

## Auth & routing

### Soft gate

W `routing.dart` usunąć hard gate:

```dart
FirebaseAuth.instance.currentUser == null → AuthenticationPage.path
```

Zastąpić logiką:

| Stan | Zachowanie |
|---|---|
| Gość, dowolna trasa poza `/auth` i `/admin*` | Bez redirectu — treść dostępna |
| Gość na `/auth` | Pokazać login |
| Zalogowany na `/auth` | Redirect na `from` (query) albo Home |
| `/admin*` | Bez zmian: `adminGuardRedirect` (nie-admin → Home; `loading` → allow) |

`UserSessionCubit` + `router.refresh()` na zmianę sesji — bez zmian modelu.

### Powrót po loginie

Istniejący wzorzec `AuthenticationPage.loginPath(from: uri)` zostaje. Po sukcesie GoRouter kieruje na `from` albo Home.

## Drawer

W `custom_drawer.dart` (nad dividerem / dark mode; zamiast zakomentowanego logoutu):

| Sesja | Kafelek |
|---|---|
| `unauthenticated` (i nie `loading` jako „zalogowany”) | **Zaloguj** → `context.push(AuthenticationPage.loginPath(from: currentUri))` |
| `authenticated` | **Wyloguj** → `AuthenticationUtils.logout` |
| `loading` | Ukryć kafelek auth albo pokazać disabled — preferencja: **ukryć**, żeby uniknąć migania |

Ikony: login (`Icons.login`) / logout (`Icons.logout`). Etykiety PL: „Zaloguj” / „Wyloguj” (spójnie z resztą UI głosowania).

Admin tile bez zmian (`visible: state.isAdmin`).

## Głosowanie

Bez zmiany kontraktu cubitów:

- `EventVoteCubit` — `needsLogin` gdy voting open + unauthenticated; tap → login z `from`.
- `ScheduleTop5Cubit` / page — `requiresLogin` → ten sam push do `/auth?from=…`.

Po powrocie z loginu użytkownik wraca na event / Top 5 i może oddać głos (kolejny tap lub, jeśli już zaimplementowane, auto — **v1: bez auto-vote po loginie**, tylko powrót na ekran).

Q&A i pozostałe feature’y: zero nowych gate’ów.

## Edge case’y

| Case | Zachowanie |
|---|---|
| Wylogowanie z `/admin*` | Po logout + refresh → Home (admin guard) |
| Back z `/auth` bez loginu | Pop / poprzedni ekran; głos nieoddany |
| Session `loading` przy starcie | Treść widoczna; przyciski głosu jak dziś (`hidden` / nie toggle) |
| Deep link na `/auth` gdy zalogowany | Redirect `from` / Home |

## Błędy

- Błąd logowania: istniejący UI na `AuthenticationPage`.
- Błąd głosowania po loginie: istniejąca obsługa w vote / Top 5.

## Testy

1. Gość na `/` lub `/schedule` — **brak** redirectu na `/auth`.
2. Drawer: unauthenticated → Zaloguj; authenticated → Wyloguj.
3. Vote / Top 5: `needsLogin` / `requiresLogin` nadal otwiera login z `from`.
4. Zalogowany na `/auth` → redirect Home (lub `from`).
5. Dostosować testy routingu / drawera, które zakładały hard gate.

## Pliki do zmiany (orientacyjnie)

- `lib/routing/routing.dart` — soft gate
- `lib/widgets/custom_drawer.dart` — Zaloguj / Wyloguj
- Testy routingu / drawera / ewentualnie auth redirect
- Vote / Top 5 — tylko jeśli testy lub drobne dopięcie `from` (logika już jest)

## Kryteria akceptacji

- [ ] Start aplikacji bez konta → Home (lub domyślna trasa), nie ekran logowania
- [ ] Drawer: Zaloguj dla gościa, Wyloguj dla zalogowanego
- [ ] Głosowanie bez sesji → `/auth` z powrotem na event / Top 5
- [ ] Admin nadal tylko dla `isAdmin`
- [ ] Q&A dostępne bez logowania
