# Admin hub i dedykowane ekrany Głosowanie / Konkurs

Data: 2026-09-05  
Status: zatwierdzony design  
Bazuje na: istniejący panel admina (głosowanie, konkurs, historia konkursów)

## Cel

Zastąpić rozwijane sekcje (`ExpansionTile`) na jednym ekranie `/admin` strukturą:

1. **Hub** `/admin` — lista wejść do podsekcji z krótkim statusem i chipem `confId`.
2. **Dedykowany ekran Głosowanie** `/admin/voting`.
3. **Dedykowany ekran Konkurs** `/admin/contest`.

## Decyzje produktowe

| Temat | Decyzja |
|---|---|
| Nawigacja | Hub + 2 ekrany (nie osobne pozycje w drawerze, nie taby) |
| Routing | Nested GoRouter pod `/admin` |
| Stan | Jeden wspólny `AdminCubit` dla hubu i dzieci |
| Hub | Nazwa pozycji + subtitle ze statusem; chip roku w AppBarze |

## Poza zakresem

- Zmiana logiki Firestore, reguł, losowania, historii konkursów.
- Osobne pozycje Admin w drawerze (pozostaje jedna „Admin” → hub).
- Refaktor domeny engagement poza ewentualnym helperem tekstu statusu hubu.

## Trasy

| Path | Ekran |
|---|---|
| `/admin` | Hub |
| `/admin/voting` | Głosowanie |
| `/admin/contest` | Konkurs |

- Guard: dostęp gdy `matchedLocation.startsWith('/admin')` i `role == admin` (jak dziś dla `/admin`).
- Drawer: pozycja Admin `selected`, gdy lokalizacja zaczyna się od `/admin`.
- Wstecz z child → hub (`/admin`).

## Shell i stan

Parent route (shell) tworzy / dostarcza `AdminCubit` (GetIt + `BlocProvider.value` lub równoważne) współdzielony przez hub i child routes.

- Cubit **nie** jest zamykany przy nawigacji między hub ↔ voting ↔ contest.
- Zamknięcie przy wyjściu z całego drzewa `/admin` (dispose shell / jak dziś przy opuszczeniu admina — zachować jeden owner lifecycle).

## Hub UI

AppBar:

- tytuł: `Admin`
- chip: `latestConfId` (gdy dostępny)
- `ConnectionStatus`

Body (po załadowaniu, gdy `isAdmin`):

1. **Głosowanie** — `ListTile`  
   - subtitle: `włączone` albo `wyłączone` (z `config.votingEnabled`)
2. **Konkurs** — `ListTile`  
   - subtitle: `{włączone|wyłączone} · {contestStatus.name} · {N} zgłoszeń`

Tap → nawigacja do `/admin/voting` lub `/admin/contest`.

Stany loading / non-admin: jak dziś (spinner / pusty).

## Ekran Głosowanie

AppBar: `Głosowanie` + leading wstecz do hubu.

Treść: obecna zawartość `AdminVotingSection` **bez** zewnętrznego `ExpansionTile` (pełna wysokość listy: switch, daty, ranking).

## Ekran Konkurs

AppBar: `Konkurs` + leading wstecz do hubu.

Treść: obecna zawartość `AdminContestSection` **bez** zewnętrznego `ExpansionTile`.  
Wewnętrzna sekcja **Historia** (rozwijana) zostaje bez zmian zachowania.

## Architektura plików (oczekiwana)

```
features/admin/presentation/
  admin_page.dart              # hub (lub rename AdminHubPage)
  admin_shell.dart             # NEW — provider cubit + nested Outlet
  admin_voting_page.dart       # NEW
  admin_contest_page.dart      # NEW
  widgets/admin_voting_section.dart   # bez ExpansionTile wrapper
  widgets/admin_contest_section.dart  # bez ExpansionTile wrapper
```

`routing.dart`: nested `GoRoute` children pod `/admin`.

Opcjonalnie mały helper czystej funkcji:

`AdminHubStatus.votingSubtitle(config)` / `contestSubtitle(config, participantCount)` — unit-testowalny.

## Testy

- Helper subtitle (jeśli wyodrębniony).
- Routing/guard: non-admin redirect z `/admin/voting` i `/admin/contest`.
- Widget: hub pokazuje obie pozycje; sekcje nie są już `ExpansionTile` na poziomie ekranu (historia nadal może być).

## Zależności

Nie zmienia kontraktu Firestore ani API `AdminCubit` poza ewentualnym użyciem istniejących pól stanu na hubie.
