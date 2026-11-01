# ng_poland_conf_app

Official app of the NG Poland / JS Poland / AI Poland conference.

## Development

```sh
flutter pub get
dart run build_runner watch   # keeps freezed / injectable output up to date
flutter analyze
flutter test
```

Generated files (`*.freezed.dart`, `lib/app/di/injectable.config.dart`) are
committed. Recent `build_runner` versions resolve conflicting outputs on their
own, so `--delete-conflicting-outputs` is not needed.

## Architecture

```
lib/
  main.dart            bootstrap (Firebase, Hive, DI) + runApp
  app/                 composition root: DI, router, app shell (drawer)
  core/
    domain/            UseCase contracts, AppException, shared repositories
    data/              shared infrastructure (Hive, connectivity, JsonObject)
    presentation/      theme, navigation paths, shared widgets, hooks
    utils/             small pure helpers (let, castOrNull, colours)
  features/<feature>/
    domain/            entities, repository interfaces, use cases, services
    data/              data sources, models, mappers, *RepositoryImpl
    presentation/      cubits, pages, widgets
```

`edition` is the shared content module: it owns the agenda and speaker
entities that other features build on.

### Dependency rules

- `domain/` is plain Dart. It never imports Flutter, Firebase, Hive, Dio or
  another layer's code (only `core/domain` and other features' domain).
- `presentation/` talks to the domain through use cases only; it never imports
  `data/`, Firebase or Hive.
- Repositories translate infrastructure errors into `AppException`
  subclasses; cubits catch those and log through `Logger` with `error:` and
  `stackTrace:` instead of swallowing them.
- `getIt` is used only in `main.dart` and `lib/app/`. Pages receive cubits
  from `BlocProvider`s declared in `app/routing/app_router.dart`, widgets read
  them with `context.read` / `context.watch`.
- `core/` does not depend on features. The drawer reaches `CustomScaffold`
  through `AppShellScope`.

### Coding conventions

The code follows [LeanCode's Flutter coding best practices](https://leancode.co/blog/flutter-coding-best-practices),
partly enforced by `analysis_options.yaml`:

- widget classes instead of widget-returning methods; no heavy work in
  `build()` (cubits and use cases precompute view data);
- `flutter_hooks` for controllers, timers and subscriptions in widgets;
- pattern matching, `switch` expressions and destructuring instead of `!`,
  nested ternaries and `is` chains;
- collection `if` / `for` / spread instead of imperative `add` calls;
- named constants for business rules (e.g. `aiPolandSinceYear`,
  `scheduleCardNoteMaxLength`) and palette tokens for colours;
- single-purpose `Padding` / `ColoredBox` / `DecoratedBox` / `SizedBox`
  instead of `Container`;
- expressive test matchers (`isA`, `throwsA`, `expectLater`) and fakes of
  domain repositories in `test/helpers/fakes.dart`.
