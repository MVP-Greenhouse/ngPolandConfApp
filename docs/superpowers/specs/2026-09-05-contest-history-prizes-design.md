# Historia konkursów, drugi konkurs i sekcja Nagrody

Data: 2026-09-05  
Status: zatwierdzony design (rozszerzenie v1 głosowanie/konkurs/admin)  
Bazuje na: `docs/superpowers/specs/2026-08-20-voting-contest-admin-design.md`

## Cel

Rozszerzyć konkurs w ramach najnowszej konferencji o:

1. **Historię zwycięzców w panelu admina** — zakończone konkursy z nazwą i listą osób.
2. **Uruchomienie kolejnego konkursu** po `finished` — z nazwą ustawianą przez admina oraz wyborem: przenieś uczestników albo zacznij od zera.
3. **Sekcję „Nagrody” w menu bocznym** — dla użytkownika, który wygrał ≥1 konkurs w tej konferencji; lista konkursów, w których wygrał.

## Decyzje produktowe

| Temat | Decyzja |
|---|---|
| Identyfikacja konkursu | Nazwa od admina (wymagana przy otwarciu / nowym konkursie) |
| Udział w kolejnych rundach | Zwycięzcy poprzednich **mogą** dołączać do kolejnych |
| Widoczność „Nagrody” | Od razu po wygranej; zostaje, dopóki user ma ≥1 wygraną w tej konferencji |
| Start kolejnego konkursu | Admin wybiera: przenieś uczestników **albo** czysty start |
| Home po wygranej + nowy nabór | Tylko CTA aktywnego konkursu (`join` / `joined`); wygrane historyczne wyłącznie w „Nagrody” |
| Model danych | Aktywny konkurs + archiwum (`contestHistory`) — podejście A |

## Poza zakresem

- Cloud Functions / twarda ochrona serwerowa ponad obecne rules.
- Konkursy dla historycznych (nie-najnowszych) `confId`.
- Edycja / usuwanie wpisów historii po archiwizacji.
- Konfigurowalna treść nagrody poza nazwą konkursu.
- Osobne nagrody per miejsce poza istniejącym `order`.

## Model Firestore

### Aktywny konkurs — `conf/{confId}/engagement/config`

Nowe pola względem v1:

| Pole | Typ | Opis |
|---|---|---|
| `contestName` | string | Nazwa bieżącej rundy; wymagana gdy status ∈ {`open`,`drawing`} (oraz przy starcie nowego) |
| `contestId` | string | Id bieżącej rundy (np. auto-id); używane do klucza dialogu wygranej i archiwum |

Pozostałe pola v1 bez zmian (`contestEnabled`, daty, `contestStatus`: `idle` \| `open` \| `drawing` \| `finished`).

### Aktywne kolekcje (bez zmiany ścieżek)

- `conf/{confId}/contestParticipants/{uid}` — jak v1  
- `conf/{confId}/contestWinners/{uid}` — jak v1 (`displayName`, `email`, `drawnAt`, `order`)

### Historia — `conf/{confId}/contestHistory/{contestId}`

Tworzona przy **Zakończ losowanie** (snapshot, nawet gdy 0 zwycięzców):

| Pole | Typ | Opis |
|---|---|---|
| `name` | string | Nazwa konkursu w momencie finish |
| `startsAt` | timestamp | Z configu |
| `endsAt` | timestamp | Z configu |
| `finishedAt` | timestamp | Czas archiwizacji |
| `winners` | array | Snapshot: `{ uid, displayName, email, order }` |

Id dokumentu = `contestId` z configu w momencie finish. Ponowne finish tego samego id jest no-opem (dokument już istnieje) albo nadpisaniem tego samego snapshotu — implementacja: **set z merge tylko jeśli brak dokumentu; nie kasować historii**.

## Przepływ admina

### Pierwszy / bieżący konkurs

- Przy przejściu z `idle` → `open` (włączenie konkursu): wymagana **nazwa**; jeśli brak `contestId`, wygeneruj nowy.
- Losowanie i finish jak v1.
- **Finish** dodatkowo: zapis `contestHistory/{contestId}` ze snapshotem winners, potem `contestStatus = finished`.
- Jeśli `contestId` nadal pusty w momencie finish (błąd konfiguracji): wygeneruj id, zapisz do configu, potem archiwizuj pod tym id.

### Po `finished`

- Sekcja **Historia** (rozwijana): lista `contestHistory` (najnowsze pierwsze) → nazwa → zwycięzcy (`order`, imię, e-mail).
- Przycisk **Nowy konkurs** → dialog:
  - nazwa (wymagana),
  - przełącznik „Przenieś uczestników” (domyślnie wyłączony = czysty start).
- Akcja `startNewContest` (kolejność obowiązkowa):
  1. Upewnij się, że historia bieżącego `contestId` jest zapisana.
  2. Wygeneruj nowy `contestId`.
  3. Wyczyść wszystkie dokumenty w `contestWinners`.
  4. Jeśli **nie** przenosisz uczestników: wyczyść `contestParticipants`.
  5. Jeśli przenosisz: zostaw `contestParticipants` bez zmian.
  6. Zaktualizuj config: nowy `contestId`, `contestName`, `contestStatus = open` (oraz `contestEnabled` / daty według bieżących kontrolek admina).

Jeśli status ≠ `finished`, start nowego konkursu = no-op + SnackBar.

## Home i dialog wygranej

`ContestHomeViewResolver` (najnowsza konferencja):

- `winner` na home **tylko** gdy user jest w **aktywnych** `contestWinners`.
- Wygrane wyłącznie w `contestHistory` **nie** dają banera/dialogu na home.
- Przy otwartym naborze aktywnego konkursu: `join` / `joined` jak v1 — także dla osób z historycznymi wygranymi.
- `loser`: jak v1 względem **aktywnego** konkursu (`finished` + participant + nie w aktywnych winners).

Dialog „Gratulacje!”: flaga lokalna keyed **`contestId`** (nie sam `confId`), żeby każde nowe losowanie mogło pokazać dialog ponownie.

## Drawer — „Nagrody”

- Pozycja widoczna gdy zalogowany user ma ≥1 wygraną w najnowszej konferencji:
  - uid w dowolnym `contestHistory.*.winners`, **lub**
  - dokument w aktywnych `contestWinners`.
- Trasa: `/prizes`.
- Ekran: lista bez duplikatów po `contestId`:
  1. wszystkie wpisy `contestHistory`, w których `winners` zawiera uid użytkownika,
  2. plus aktywna wygrana (`contestWinners/{uid}`), **tylko jeśli** `config.contestId` nie ma jeszcze dokumentu w `contestHistory`.
- Każda pozycja: `contestName`, `order`, opcjonalnie `finishedAt` (dla historii).
- Wejście w drawerze: osobna pozycja warunkowa (jak Admin — poza zwykłą pętlą `Pages`), widoczna tylko przy ≥1 nagrodzie.
- Wejście na `/prizes` bez żadnej nagrody → redirect home.

## Architektura w aplikacji

- Domain: `EngagementConfig` + `contestName`/`contestId`; entity `ContestHistoryEntry`; helper widoczności nagród; aktualizacja `ContestHomeViewResolver`.
- Contest repository/datasource: `archiveOnFinish`, `startNewContest`, `watchHistory`, `watchMyPrizes(uid)`.
- Admin UI: historia + dialog nowego konkursu + pole nazwy.
- `Pages.prizes` nie jest wymagane w enumie nawigacji głównej; pozycja drawer + trasa `/prizes` + guard (jak Admin).
- GetIt / Cubit zgodnie z projektem.

## Firestore rules

- `contestHistory/{contestId}`: odczyt dla zalogowanych; zapis tylko admin (`role == admin`).
- Reszta jak v1 (`config`, `contestParticipants`, `contestWinners`).

## Błędy

- Pusta nazwa przy open / nowym konkursie → walidacja w UI, brak zapisu.
- Nieudany zapis historii → **nie** czyścić winners/participants i nie resetować statusu (najpierw archive, potem reset).
- Pusta pula przy losowaniu → jak v1.
- Brak sieci → jak v1 (`ConnectionStatus`, nieaktywne akcje).

## Testy

- Resolver: historyczny zwycięzca + aktywny `open` → `join`/`joined`, nie `winner`.
- Resolver: aktywny winner → `winner` niezależnie od historii.
- Widoczność „Nagrody”: 0 vs ≥1 wygrana (historia i/lub aktywni winners).
- Finish → dokument w `contestHistory` (także 0 winners).
- `startNewContest` z carry: participants zostają, winners puste, nowy `contestId`/`name`, status `open`.
- `startNewContest` bez carry: participants i winners puste.
- Dialog win: klucz per `contestId`.

## Zależność od v1

Implementacja zakłada istniejące ścieżki `contestParticipants` / `contestWinners` / `engagement/config` oraz statusy konkursu z designu 2026-08-20. To jest **przyrost**, nie zamiana całego modelu konkursu na `contests/{id}`.
