import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/engagement/data/datasources/engagement_config_remote_datasource.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/exceptions/engagement_exception.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/repositories/engagement_config_repository.dart';

@Singleton(as: EngagementConfigRepository)
class EngagementConfigRepositoryImpl implements EngagementConfigRepository {
  const EngagementConfigRepositoryImpl(this._remoteDataSource, this._logger);

  final EngagementConfigRemoteDataSource _remoteDataSource;
  final Logger _logger;

  @override
  Stream<EngagementConfig> watchConfig(String confId) =>
      _remoteDataSource.watchConfig(confId);

  @override
  Future<void> saveTrackConfig({
    required String confId,
    required EventItemType track,
    required TrackEngagementConfig config,
  }) async {
    try {
      await _remoteDataSource.saveTrackConfig(
        confId: confId,
        track: track,
        config: config,
      );
    } on FirebaseException catch (error, stackTrace) {
      _logger.w(
        'Saving engagement config failed',
        error: error,
        stackTrace: stackTrace,
      );
      throw const EngagementException('Could not save the voting settings.');
    }
  }
}
