import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:ng_poland_conf_app/features/engagement/data/datasources/votable_event_remote_datasource.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/entities/votable_event.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/exceptions/engagement_exception.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/repositories/votable_event_repository.dart';

@Singleton(as: VotableEventRepository)
class VotableEventRepositoryImpl implements VotableEventRepository {
  const VotableEventRepositoryImpl(this._remote, this._logger);

  final VotableEventRemoteDataSource _remote;
  final Logger _logger;

  @override
  Stream<VotableEvent?> watchEvent({
    required String confId,
    required String eventId,
  }) => _remote.watchEvent(confId: confId, eventId: eventId);

  @override
  Future<Map<String, VotableEvent>> loadEvents(String confId) async {
    try {
      return await _remote.loadEvents(confId);
    } on FirebaseException catch (error, stackTrace) {
      _logger.w(
        'Loading votable events failed',
        error: error,
        stackTrace: stackTrace,
      );
      throw const EngagementException();
    }
  }

  @override
  Future<void> replaceCatalog({
    required String confId,
    required List<VotableEvent> events,
  }) async {
    try {
      await _remote.replaceCatalog(confId: confId, events: events);
    } on FirebaseException catch (error, stackTrace) {
      _logger.w(
        'Saving votable events failed',
        error: error,
        stackTrace: stackTrace,
      );
      throw const EngagementException('Could not update the voting list.');
    }
  }
}
