extension LetExtension<T extends Object> on T {
  /// Applies [transform] to this value; handy after `?.` on nullable values.
  R let<R>(R Function(T it) transform) => transform(this);
}

extension CastOrNullExtension on Object? {
  /// Returns this value as [T], or `null` when it has a different type.
  ///
  /// Use only where invalid data is equivalent to missing data (e.g. loosely
  /// typed JSON); prefer `as` when a wrong type is a bug worth surfacing.
  T? castOrNull<T>() {
    final self = this;
    return self is T ? self : null;
  }
}
