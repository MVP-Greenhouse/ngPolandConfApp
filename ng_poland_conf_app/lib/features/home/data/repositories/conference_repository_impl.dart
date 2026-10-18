import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/conference.dart';
import 'package:ng_poland_conf_app/features/edition/domain/repositories/edition_repository.dart';
import 'package:ng_poland_conf_app/features/edition/domain/services/edition_projections.dart';
import 'package:ng_poland_conf_app/features/home/domain/repositories/conference_repository.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: ConferenceRepository)
class ConferenceRepositoryImpl implements ConferenceRepository {
  ConferenceRepositoryImpl(this._editions);

  final EditionRepository _editions;
  final _current = BehaviorSubject<Conference>();

  @override
  Conference? get current => _current.valueOrNull;

  @override
  Future<Conference> loadCurrent() async {
    final conference = conferenceFromEdition(await _editions.load());
    if (_current.valueOrNull != conference) _current.add(conference);
    return conference;
  }

  @override
  Stream<Conference> watchCurrent() => _current.stream;

  /// Closes the stream (used by tests; the app keeps it alive).
  Future<void> dispose() => _current.close();
}
