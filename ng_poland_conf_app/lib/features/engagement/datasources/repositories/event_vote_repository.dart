import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/engagement/datasources/data/event_vote_remote_datasource.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/event_vote_counts.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/event_vote_repository.dart';

@Singleton(as: EventVoteRepository)
class EventVoteRepositoryImpl implements EventVoteRepository {
  const EventVoteRepositoryImpl(this._remoteDataSource);

  final EventVoteRemoteDataSource _remoteDataSource;

  @override
  Stream<bool> watchMyLike({
    required String confId,
    required String eventId,
    required String uid,
  }) {
    return _remoteDataSource.watchMyLike(
      confId: confId,
      eventId: eventId,
      uid: uid,
    );
  }

  @override
  Future<void> setLike({
    required String confId,
    required String eventId,
    required String uid,
    required bool liked,
  }) {
    return _remoteDataSource.setLike(
      confId: confId,
      eventId: eventId,
      uid: uid,
      liked: liked,
    );
  }

  @override
  Future<Map<String, EventVoteCounts>> loadVoteCounts(String confId) {
    return _remoteDataSource.loadVoteCounts(confId);
  }
}
