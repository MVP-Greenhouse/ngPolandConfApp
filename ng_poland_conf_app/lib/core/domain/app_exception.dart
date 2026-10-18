/// Base type for failures the domain layer reports to presentation.
///
/// Repositories translate infrastructure errors (Firebase, Dio, Hive) into
/// subclasses of this type so cubits never depend on data-layer exceptions.
abstract class AppException implements Exception {
  const AppException(this.message);

  /// Human readable description, safe to show in the UI.
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}
