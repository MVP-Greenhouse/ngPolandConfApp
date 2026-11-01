import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:ng_poland_conf_app/features/engagement/data/datasources/event_vote_remote_datasource.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/entities/event_vote_counts.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/exceptions/engagement_exception.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/repositories/event_vote_repository.dart';

@Singleton(as: EventVoteRepository)
class EventVoteRepositoryImpl implements EventVoteRepository {
  const EventVoteRepositoryImpl(this._remoteDataSource, this._logger);

  final EventVoteRemoteDataSource _remoteDataSource;
  final Logger _logger;

  @override
  Stream<bool> watchMyLike({
    required String confId,
    required String eventId,
    required String uid,
  }) =>
      _remoteDataSource.watchMyLike(confId: confId, eventId: eventId, uid: uid);

  @override
  Future<void> setLike({
    required String confId,
    required String eventId,
    required String uid,
    required bool liked,
  }) async {
    try {
      await _remoteDataSource.setLike(
        confId: confId,
        eventId: eventId,
        uid: uid,
        liked: liked,
      );
    } on FirebaseException catch (error, stackTrace) {
      _logger.w('Saving vote failed', error: error, stackTrace: stackTrace);
      throw const EngagementException('Could not save your vote.');
    }
  }

  @override
  Future<Map<String, EventVoteCounts>> loadVoteCounts(String confId) async {
    try {
      return await _remoteDataSource.loadVoteCounts(confId);
    } on FirebaseException catch (error, stackTrace) {
      _logger.w(
        'Loading vote counts failed',
        error: error,
        stackTrace: stackTrace,
      );
      throw const EngagementException();
    }
  }
}
