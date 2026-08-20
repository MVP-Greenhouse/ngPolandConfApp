import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/engagement/datasources/data/contest_remote_datasource.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_participant.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_status.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_winner.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/contest_repository.dart';

@Singleton(as: ContestRepository)
class ContestRepositoryImpl implements ContestRepository {
  const ContestRepositoryImpl(this._remoteDataSource);

  final ContestRemoteDataSource _remoteDataSource;

  @override
  Stream<ContestParticipant?> watchMyParticipation({
    required String confId,
    required String uid,
  }) {
    return _remoteDataSource.watchMyParticipation(confId: confId, uid: uid);
  }

  @override
  Future<void> join({
    required String confId,
    required String uid,
    required String displayName,
    required String email,
  }) {
    return _remoteDataSource.join(
      confId: confId,
      uid: uid,
      displayName: displayName,
      email: email,
    );
  }

  @override
  Stream<List<ContestParticipant>> watchParticipants(String confId) {
    return _remoteDataSource.watchParticipants(confId);
  }

  @override
  Stream<ContestWinner?> watchMyWin({
    required String confId,
    required String uid,
  }) {
    return _remoteDataSource.watchMyWin(confId: confId, uid: uid);
  }

  @override
  Stream<List<ContestWinner>> watchWinners(String confId) {
    return _remoteDataSource.watchWinners(confId);
  }

  @override
  Future<void> saveWinners({
    required String confId,
    required List<ContestWinner> winners,
  }) {
    return _remoteDataSource.saveWinners(confId: confId, winners: winners);
  }

  @override
  Future<void> updateContestStatus({
    required String confId,
    required ContestStatus status,
  }) {
    return _remoteDataSource.updateContestStatus(
      confId: confId,
      status: status,
    );
  }
}
