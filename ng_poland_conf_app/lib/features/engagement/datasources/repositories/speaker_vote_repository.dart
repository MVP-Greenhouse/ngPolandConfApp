import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/engagement/datasources/data/speaker_vote_remote_datasource.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/speaker_vote_counts.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/speaker_vote_value.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/speaker_vote_repository.dart';

@Singleton(as: SpeakerVoteRepository)
class SpeakerVoteRepositoryImpl implements SpeakerVoteRepository {
  const SpeakerVoteRepositoryImpl(this._remoteDataSource);

  final SpeakerVoteRemoteDataSource _remoteDataSource;

  @override
  Stream<SpeakerVoteValue?> watchMyVote({
    required String confId,
    required String speakerId,
    required String uid,
  }) {
    return _remoteDataSource.watchMyVote(
      confId: confId,
      speakerId: speakerId,
      uid: uid,
    );
  }

  @override
  Future<void> setVote({
    required String confId,
    required String speakerId,
    required String uid,
    SpeakerVoteValue? value,
  }) {
    return _remoteDataSource.setVote(
      confId: confId,
      speakerId: speakerId,
      uid: uid,
      value: value,
    );
  }

  @override
  Stream<Map<String, SpeakerVoteValue>> watchAllVotes({
    required String confId,
    required String speakerId,
  }) {
    return _remoteDataSource.watchAllVotes(
      confId: confId,
      speakerId: speakerId,
    );
  }

  @override
  Future<Map<String, SpeakerVoteCounts>> loadVoteCounts(String confId) {
    return _remoteDataSource.loadVoteCounts(confId);
  }
}
