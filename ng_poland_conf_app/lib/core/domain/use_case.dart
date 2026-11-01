/// A single application action exposed by a feature's domain layer.
///
/// Presentation depends on use cases only, never on repositories or data
/// sources, so every cubit talks to the domain through one of these contracts.
abstract interface class UseCase<T, P> {
  Future<T> call(P params);
}

abstract interface class NoParamsUseCase<T> {
  Future<T> call();
}

abstract interface class StreamUseCase<T, P> {
  Stream<T> call(P params);
}

abstract interface class NoParamsStreamUseCase<T> {
  Stream<T> call();
}
