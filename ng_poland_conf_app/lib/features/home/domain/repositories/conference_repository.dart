import 'package:ng_poland_conf_app/features/edition/domain/entities/conference.dart';

abstract interface class ConferenceRepository {
  /// Latest loaded conference, or `null` before the first load.
  Conference? get current;

  /// Loads the current conference and publishes it to [watchCurrent].
  ///
  /// Throws `EditionUnavailableException` when there is no data.
  Future<Conference> loadCurrent();

  /// Replays the latest loaded conference, then emits later loads.
  Stream<Conference> watchCurrent();
}
