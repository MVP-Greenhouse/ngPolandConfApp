import 'package:ng_poland_conf_app/features/edition/domain/entities/edition.dart';
import 'package:ng_poland_conf_app/features/edition/domain/exceptions/edition_unavailable_exception.dart';

abstract interface class EditionRepository {
  /// Returns the current edition, preferring a fresh in-memory or disk copy.
  ///
  /// Throws [EditionUnavailableException] when nothing is available.
  Future<Edition> load();

  /// Always asks the API. On failure throws [EditionUnavailableException]
  /// and leaves the cached edition untouched, so callers never act on a
  /// stale catalog.
  Future<Edition> refresh();
}
