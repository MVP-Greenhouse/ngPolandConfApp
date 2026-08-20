import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/engagement/datasources/data/engagement_config_remote_datasource.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/engagement_config_repository.dart';

@Singleton(as: EngagementConfigRepository)
class EngagementConfigRepositoryImpl implements EngagementConfigRepository {
  const EngagementConfigRepositoryImpl(this._remoteDataSource);

  final EngagementConfigRemoteDataSource _remoteDataSource;

  @override
  Stream<EngagementConfig> watchConfig(String confId) {
    return _remoteDataSource.watchConfig(confId);
  }

  @override
  Future<void> saveConfig(String confId, EngagementConfig config) {
    return _remoteDataSource.saveConfig(confId, config);
  }
}
