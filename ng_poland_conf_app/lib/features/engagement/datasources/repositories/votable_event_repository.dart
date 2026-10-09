import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/engagement/datasources/data/votable_event_remote_datasource.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/votable_event.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/votable_event_repository.dart';

@Singleton(as: VotableEventRepository)
class VotableEventRepositoryImpl implements VotableEventRepository {
  const VotableEventRepositoryImpl(this._remote);

  final VotableEventRemoteDataSource _remote;

  @override
  Stream<VotableEvent?> watchEvent({
    required String confId,
    required String eventId,
  }) {
    return _remote.watchEvent(confId: confId, eventId: eventId);
  }

  @override
  Future<Map<String, VotableEvent>> loadEvents(String confId) {
    return _remote.loadEvents(confId);
  }

  @override
  Future<void> replaceCatalog({
    required String confId,
    required List<VotableEvent> events,
  }) {
    return _remote.replaceCatalog(confId: confId, events: events);
  }
}
