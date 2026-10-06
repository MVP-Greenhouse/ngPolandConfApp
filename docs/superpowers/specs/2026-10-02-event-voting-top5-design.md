# Głosowanie na prelekcje, Top 5 i usunięcie contestu

Data: 2026-10-02  
Status: zatwierdzony design (refactor `engagement` in-place; klient + Firestore v1)  
Aktualizacja: 2026-10-02 — konfiguracja **per `confId` × track** (NG / JS / AI)

## Cel

Zastąpić obecny system engagement:

1. **Usunąć** głosowanie na speakerów (👍/👎), cały **contest** (home, admin, Firestore flow) oraz **nagrody** (`/prizes`, drawer).
2. **Wprowadzić** głosowanie na **prelekcje** (eventy schedule z speakerem): jedna łapka w górę, możliwość odwołania, bez limitu liczby prelekcji.
3. **Top 5** — osobny ranking per track na Schedule / dedykowany ekran Ranking Top 5; włączany **niezależnie per track**.
4. **Admin** — dla wybranego **roku × track**: włączenie/wyłączenie głosowania, okno Od–Do, **„Zakończ teraz”**, włączenie/wyłączenie Top 5, ranking prelekcji tego tracka.

Logowanie wymagane do oddania głosu. Scope publiczny: tylko **najnowsza konferencja** (`LatestConferenceResolver`). Admin może edytować dowolny `confId` z listy.

## Decyzje produktowe (z brainstormingu)

| Temat | Decyzja |
|---|---|
| Zakres usunięć | Speaker voting + contest + prizes (całkowicie z UI i kodu) |
| Typ głosu | Tylko 👍 (toggle like / unlike) |
| Gdzie głosować | Wyłącznie `EventPage` |
| Na co głosować | Eventy schedule **z speakerem** |
| Top 5 | Per aktualny track na Schedule |
| Granularność config | **`confId` × `EventItemType`** (rok + track) |
| Okno głosowania | Per track: `votingStartsAt`–`votingEndsAt` + **„Zakończ teraz”** |
| Głosowanie zamknięte | Przycisk 👍 **ukryty** na `EventPage` |
| Liczba głosów użytkownika | Bez limitu (1 głos na event) |
| Storage config | Jedna mapa `tracks` w `engagement/config` |
| Architektura | Refactor feature `engagement` in-place |

## Poza zakresem (v1)

- Cloud Functions, denormalizowane liczniki głosów.
- Automatyczny zapis migracji flat → `tracks` (tylko odczyt z fallbackiem).
- Migracja danych ze starych `speakerVotes` / contest collections.
- Głosowanie z listy schedule.
- Zmiana ocen gwiazdkowych eventów (`EventRatingBloc`).
- Publiczne głosowanie / Top 5 dla historycznych konferencji (admin może je konfigurować).

## Model Firestore

Pod `conf/{confId}/`:

### `engagement/config` (jeden dokument)

```json
{
  "tracks": {
    "ngPoland": {
      "votingEnabled": true,
      "votingStartsAt": "<timestamp>",
      "votingEndsAt": "<timestamp>",
      "top5Enabled": true
    },
    "jsPoland": { "...": "..." },
    "aiPoland": { "...": "..." }
  }
}
```

| Ścieżka | Typ | Opis |
|---|---|---|
| `tracks.{trackId}.votingEnabled` | bool | master switch głosowania tracka |
| `tracks.{trackId}.votingStartsAt` | timestamp | początek okna |
| `tracks.{trackId}.votingEndsAt` | timestamp | koniec okna |
| `tracks.{trackId}.top5Enabled` | bool | czy pokazywać Top 5 / banner wyników dla tracka |

`trackId` = `EventItemType.name` (`ngPoland` / `jsPoland` / `aiPoland`). Tracki niedostępne dla danego roku (np. `aiPoland` przed 2025) mogą nie istnieć w mapie.

**Migracja odczytu (legacy flat):** jeśli brak `tracks`, a dokument ma stare pola `votingEnabled` / `votingStartsAt` / `votingEndsAt` / `top5Enabled` → użyj ich jako default `TrackEngagementConfig` dla każdego tracka przy odczycie. **Nie zapisuj** automatycznie; pierwszy zapis admina zapisze mapę `tracks`.

Pola contestu (`contestEnabled`, itd.) — ignorowane przy odczycie; przy zapisie merge nie kasuje ich.

**Głosowanie otwarte (track T):** `tracks[T].votingEnabled && now ∈ [start, end]` (granice włącznie, UTC).

**„Zakończ teraz”:** `tracks[T].votingEndsAt = now` (UTC) — **tylko wybrany track**.

### Głosy na eventy

`conf/{confId}/eventVotes/{eventId}/votes/{uid}`

| Pole | Typ | Opis |
|---|---|---|
| `value` | int | `1` = like; brak dokumentu = brak głosu |
| `updatedAt` | timestamp | ostatnia zmiana |

Toggle: ponowne 👍 → usunięcie dokumentu. Id eventu: Contentful `EventItem.id`.

### Kolekcje nieużywane (legacy)

- `speakerVotes/...`
- `contestParticipants`, `contestWinners`, `contestHistory`

## Reguły biznesowe

- Głos tylko gdy: najnowszy `confId` wybrany, głosowanie **tracka eventu** otwarte, użytkownik zalogowany, event ma speakera.
- Użytkownik **nie widzi** liczby głosów na `EventPage`.
- Banner / Top 5 na Schedule: wg **aktualnego tracka** + najnowsza konferencja + `tracks[T].top5Enabled` (i/lub otwarte głosowanie dla banneru „na żywo”).
- Gdy głosowanie tracka zamknięte, ale `top5Enabled`: banner „Ranking Top 5” + karta „Głosowanie zakończone” na ekranie rankingu.
- Ranking Top 5: sort malejąco po 👍; remis po tytule, potem `eventId`.
- Tap wiersza → `EventPage`.

## UI

### Schedule

- Banner na górze listy wg stanu **aktualnego tracka**.
- Tap (gdy Top 5 włączone) → `/schedule/top5/:eventItemType`.
- Przy zmianie tracka (bottom nav) banner i Top 5 przeładowują się.

### EventPage

- `EventVoteButton` widoczny gdy track eventu ma otwarte głosowanie (+ speaker, latest conf).
- Niezalogowany → login.

### Admin

- Hub `/admin`: karta **Głosowanie**; statusy dla **wybranego** roku × track; dropdown roku w AppBar.
- `/admin/voting`: wybór roku + segmented track (NG / JS / AI; AI od 2025+); formularz edytuje **tylko wybrany track**; ranking filtruje po tracku.
- Usunięte: contest, prizes, speaker vote UI.

## Architektura (Flutter)

| Element | Opis |
|---|---|
| `TrackEngagementConfig` | `votingEnabled`, `votingStartsAt`, `votingEndsAt`, `top5Enabled`, `isVotingOpen` |
| `EngagementConfig` | `Map<EventItemType, TrackEngagementConfig> tracks` + `forTrack(type)` (brak → `missing`) |
| Mapper | odczyt `tracks` / fallback flat; zapis mapy `tracks` z merge |
| Repo | `watchConfig(confId)`; `saveTrackConfig(confId, track, TrackEngagementConfig)` |
| `AdminCubit` | `selectedConfId` + `selectedTrack`; save/end/top5 na wybranym tracku |
| Banner / Top5 / EventVote cubits | config **konkretnego tracka** |

DI: injectable; bez contest/prizes.

## Agregacja głosów (v1)

Client-side: eventy tracka + `loadVoteCounts`. Akceptowalne dla skali konferencji.

## Błędy i edge case’y

- Offline przy toggle: komunikat, stan z ostatniego udanego odczytu.
- Brak config / brak tracka w mapie: `TrackEngagementConfig.missing` (wyłączone).
- Event usunięty z Contentful: pomiń w Top 5; w adminie można pokazać id.

## Testy

- Unit: `forTrack`, mapper tracks + legacy flat fallback, window / end now per track.
- Cubit: admin select track/save, banner/top5/event vote z trackowym configiem.
- Widget: admin track selector + voting section.

## Pliki wysokiego wpływu

- `lib/features/engagement/**` (entity, mappers, repo)
- `lib/features/admin/**`
- `lib/features/event/presentation/**`
- `lib/features/schedule/presentation/**`
- `test/features/engagement/**`, `test/features/admin/**`

## Dokumenty zastępujące / relacja

Ten spec **zastępuje funkcjonalnie** elementy z:

- `2026-08-20-voting-contest-admin-design.md`
- `2026-09-05-contest-history-prizes-design.md`

Historyczne plany pozostają jako archiwum; implementacja według tego dokumentu (w tym aktualizacji per-track).
