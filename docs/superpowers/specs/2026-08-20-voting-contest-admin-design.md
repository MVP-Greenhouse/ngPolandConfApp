# Głosowanie, konkurs i panel admina

Data: 2026-08-20  
Status: zatwierdzony design (v1, klient + Firestore; później możliwa podmiana na własny backend)

## Cel

Dodać do aplikacji NG Poland trzy powiązane funkcje oparte o Firebase:

1. **Panel admina** — statystyki głosów na speakerów oraz sterowanie i losowanie konkursu. Widoczny wyłącznie dla użytkownika z `role: admin`.
2. **Głosowanie na speakerów** — łapka w górę / w dół (jak YouTube). Zwykły użytkownik widzi tylko swój głos. Admin widzi ranking w panelu.
3. **Konkurs** — przycisk „Dołącz do konkursu” na stronie głównej, włączany z panelu admina. Po losowaniu zwycięzcy dostają dialog i baner; przegrani uczestnicy — komunikat na home dopiero po zakończeniu losowania.

Aplikacja nadal działa bez logowania. Logowanie (Google/Apple) jest wymagane dopiero przy głosowaniu, dołączeniu do konkursu albo wejściu na panel admina.

## Poza zakresem (v1)

- Cloud Functions i twarda ochrona po stronie serwera (świadomy kompromis na czas testów).
- Wymuszenie logowania w całej aplikacji (obecny redirect w routerze zostaje wyłączony).
- Konfigurowalna treść nagrody / wiele nagród.
- Głosowanie z listy speakerów.
- Głosowanie i konkurs dla historycznych konferencji.
- Zmiana istniejącego oceniania eventów (gwiazdki).

Docelowo ten sam kontrakt danych ma dać się obsłużyć własnym backendem bez przebudowy UI.

## Kontekst w kodzie

- Flutter, clean architecture, BLoC/Cubit, GetIt, GoRouter, Material 3.
- Firebase Auth już jest (Google/Apple); dokument użytkownika w Firestore **nie** jest dziś tworzony.
- Oceny eventów: `conf/{confId}/{eventItemType}/{eventId}/rates/{uid}`.
- Speakerzy pochodzą z Contentful; konferencje z `ConferencesCubit` (wybór `confId` w dropdownie).
- Home: timer + opis konferencji. Drawer renderuje wszystkie wartości `Pages`.

## Najnowsza konferencja

Głosowanie, konkurs i zapis konfiguracji w panelu admina dotyczą **wyłącznie najnowszej konferencji**: najwyższy numeryczny `confId` z listy konferencji.

Jeśli użytkownik ma wybraną starszą konferencję: brak łapek, brak przycisku konkursu, brak banerów wyniku. Panel admina zawsze czyta i zapisuje dane najnowszego `confId` (etykieta roku w AppBarze), niezależnie od dropdownu na home.

## Role i konta

Ścieżka: `users/{uid}`

| Pole | Opis |
|---|---|
| `displayName` | z Google/Apple |
| `email` | z Google/Apple |
| `role` | `user` (domyślnie) albo `admin` |
| `createdAt` | timestamp pierwszego logowania |

Przy pierwszym udanym logowaniu aplikacja tworzy dokument z `role: user`, jeśli nie istnieje. **Nigdy** nie nadaje `admin`. Rolę admina ustawiacie ręcznie w konsoli Firebase.

Pozycja „Admin” w drawerze i trasa `/admin` tylko gdy zalogowany user ma `role == admin`. Inaczej redirect na home. Tap na głos / „Dołącz” bez sesji: ekran logowania, po sukcesie powrót do poprzedniego miejsca.

## Model Firestore

Wszystko (poza profilem) pod `conf/{confId}/`, analogicznie do ocen eventów.

### `conf/{confId}/engagement/config` (jeden dokument)

| Pole | Typ | Opis |
|---|---|---|
| `votingEnabled` | bool | przełącznik w panelu |
| `votingStartsAt` | timestamp | początek okna głosowania |
| `votingEndsAt` | timestamp | koniec okna |
| `contestEnabled` | bool | przełącznik konkursu |
| `contestStartsAt` | timestamp | początek okna naboru |
| `contestEndsAt` | timestamp | koniec okna naboru |
| `contestStatus` | string | `idle` \| `open` \| `drawing` \| `finished` |

`contestStatus`:

- `idle` — konkurs nieaktywny (domyślnie).
- `open` — admin włączył konkurs; nabór możliwy, o ile trwa okno dat.
- `drawing` — nastąpiło **pierwsze** udane losowanie; nabór zamknięty; można losować dalej.
- `finished` — admin kliknął „Zakończ losowanie”; przegrani uczestnicy widzą komunikat na home.

### Głosy

`conf/{confId}/speakerVotes/{speakerId}/votes/{uid}`

| Pole | Typ |
|---|---|
| `value` | `1` (góra) albo `-1` (dół) |
| `updatedAt` | timestamp |

Brak dokumentu = brak głosu. Ponowne kliknięcie tej samej łapki **usuwa** dokument. Druga łapka nadpisuje `value`.

Agregaty (👍 / 👎 per speaker) w v1 liczy **klient admina** z listy dokumentów głosów. Brak osobnego dokumentu statystyk.

### Konkurs

`conf/{confId}/contest/participants/{uid}`

| Pole | Typ |
|---|---|
| `displayName` | string |
| `email` | string |
| `joinedAt` | timestamp |

`conf/{confId}/contest/winners/{uid}`

| Pole | Typ |
|---|---|
| `displayName` | string |
| `email` | string |
| `drawnAt` | timestamp |
| `order` | int (kolejność losowania, od 1) |

## Kiedy widać UI

**Łapki na szczegółach speakera** — wszystkie warunki naraz:

- wybrany `confId` to najnowsza konferencja
- `votingEnabled == true`
- teraz ∈ `[votingStartsAt, votingEndsAt]`
- użytkownik zalogowany (niezalogowany: tap → logowanie, potem łapki)

Poza oknem / przy wyłączonym głosowaniu łapki **znikają**. User nadal nie widzi liczb, tylko wyróżnienie swojej łapki.

**Przycisk „Dołącz do konkursu” na home** — wszystkie naraz:

- wybrany `confId` to najnowsza konferencja
- `contestEnabled == true`
- teraz ∈ `[contestStartsAt, contestEndsAt]`
- `contestStatus` to `idle` albo `open` (przed pierwszym losowaniem)
- użytkownik jeszcze nie ma dokumentu w `participants`

Po dołączeniu: nieaktywny stan „Dołączono do konkursu”.  
Po pierwszym losowaniu (`drawing`) przycisk znika.  
Niezalogowany tap → logowanie → powrót; jeśli nadal można dołączyć, join nie dzieje się sam — user klika jeszcze raz (jawna zgoda).

**Baner wygranej na home** — użytkownik jest w `winners` (od razu po wylosowaniu), najnowsza konferencja wybrana.

**Dialog „Gratulacje!”** — tylko zwycięzcom, gdy pojawi się ich dokument w `winners`. Pokazać raz na daną konferencję (flaga lokalna keyed `confId`). Jeśli apka była zamknięta, dialog przy następnym otwarciu (o ile flaga nieustawiona). Przegrani **nie** dostają dialogu.

**Baner przegranej** (`Niestety nie udało się, może innym razem`) — `contestStatus == finished` **oraz** user jest w `participants` **oraz** nie jest w `winners`. Nie pokazujemy tego osobom, które nie brały udziału.

Treść v1 (niekonfigurowalna):

- Dialog / baner wygranej: „Wygrałeś nagrodę w konkursie. Odebrać możesz ją w strefie organizatorów.”
- Baner przegranej: „Niestety nie udało się, może innym razem”

## Panel admina

Trasa: `/admin`. Wejście w drawerze tylko dla admina.

Sekcja **Głosowanie**:

- przełącznik włączenia
- data/czas od–do
- ranking speakerów: nazwa, liczba 👍, liczba 👎, sortowanie malejąco po 👍 (przy remisie po mniejszej liczbie 👎)

Sekcja **Konkurs**:

- przełącznik włączenia (ustawia `contestStatus` na `open`, gdy włączany z `idle`)
- data/czas od–do
- status + liczba zgłoszeń
- pole „ile wylosować” + przycisk **Losuj N**
- przycisk **Losuj 1**
- lista wylosowanych: `order`, `displayName`, `email`
- **Zakończ losowanie** — aktywne od statusu `drawing`; ustawia `finished`

Losowanie (klient admina):

1. Pobierz `participants` minus już istniejący `winners`.
2. Jeśli pusta pula: SnackBar, bez zmiany statusu.
3. Wylosuj bez zwracania (N albo 1, N przycięte do rozmiaru puli).
4. Zapisz dokumenty w `winners` z kolejnym `order`.
5. Jeśli status był `idle`/`open`: ustaw `drawing` (nabór zamknięty).

Okno dat naboru może się skończyć przed losowaniem — przycisk join znika u userów, admin nadal może losować.

## Przepływ danych

Nasłuch (`snapshots`):

| Kto | Co |
|---|---|
| Home | `engagement/config`; po zalogowaniu: własny `participants/{uid}` i `winners/{uid}` |
| Szczegóły speakera | własny `votes/{uid}` + `config` (czy pokazać łapki) |
| Admin | `config`, wszystkie `votes` (agregacja), `participants`, `winners` |
| Drawer / router | `users/{uid}.role` |

Zapis:

- głos: set albo delete wyłącznie własnego `votes/{uid}`
- join: set własnego `participants/{uid}` (imię, e-mail z profilu)
- config, winners, zmiana statusu: tylko z klienta zalogowanego jako admin

Warstwa dostępu w Flutterze: repository + datasource Firestore, tak jak `RateEventRemoteDataSource`, żeby później podmienić na HTTP.

## Firestore Rules (v1)

- `users/{uid}`: odczyt własnego dokumentu; admin może czytać wszystkie (do listy zwycięzców dane i tak są skopiowane na `winners`). Tworzenie/aktualizacja własnego dokumentu **bez** możliwości ustawienia `role` na `admin` (pole `role` przy create tylko `user`; update nie może zmienić `role`).
- `votes/{uid}`: user czyta i pisze tylko swój dokument; admin czyta całą podkolekcję.
- `participants/{uid}`: user tworzy/czyta tylko swój; admin czyta wszystkie. Brak edycji cudzych zgłoszeń.
- `config` i `winners`: odczyt dla zalogowanych; zapis tylko gdy `request.auth.uid` ma w `users` `role == admin`.

To nie blokuje złośliwego klienta w 100% (np. głos poza oknem dat, jeśli rules nie sprawdzą timestampów). Na v1 akceptujemy kontrolę w UI + podstawowe rules; backend docelowo tnnie to twardo.

## Błędy

- Brak sieci: przyciski nieaktywne, istniejący `ConnectionStatus`.
- Nieudany zapis głosu / join: SnackBar, stan UI bez optymistycznego „na sztywno” po błędzie.
- Losowanie przy pustej puli: komunikat, status bez zmian.
- `/admin` bez roli admin: redirect home.
- Brak `displayName`/`email` z providera: zapisujemy puste stringi; admin i tak widzi `uid` w ścieżce dokumentu — w UI listy pokazujemy e-mail albo „brak danych”, nigdy nie blokujemy join.

## Testy

- Stany home względem `config` + własne dokumenty: brak CTA / Dołącz / Dołączono / baner wygranej / baner przegranej (przegrana tylko przy `finished` i uczestnictwie bez wygranej).
- Głos: ustaw / zmień / cofnij; brak liczb dla roli user.
- Admin: pierwsze losowanie → `drawing`; kolejne losowania nie biorą już zwycięzców; finish → `finished`.
- Drawer: pozycja Admin tylko przy `role: admin`.
- Najnowszy `confId`: przy wybranej starszej konferencji brak łapek i CTA.

## Moduły w aplikacji

Nowe feature’y w istniejącym układzie katalogów:

- `features/admin` — strona, cubit, datasource config/votes/contest
- rozszerzenie `features/speakers` — łapki na `SpeakerDetails`
- rozszerzenie `features/home` — CTA konkursu, banery, dialog
- `features/authentication` — create-if-missing `users/{uid}`; nawigacja „zaloguj i wróć”
- `routing/routing.dart` — `/admin` + guard
- `widgets/custom_drawer.dart` — pozycja Admin poza `Pages` (żeby nie trafiła do zwykłego użytkownika)

BLoC/Cubit + GetIt, zgodnie z resztą projektu.
