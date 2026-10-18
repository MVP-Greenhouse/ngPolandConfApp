import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/domain/use_case.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/repositories/engagement_config_repository.dart';

/// Engagement config of the conference with the given id.
@injectable
class WatchEngagementConfig implements StreamUseCase<EngagementConfig, String> {
  const WatchEngagementConfig(this._configs);

  final EngagementConfigRepository _configs;

  @override
  Stream<EngagementConfig> call(String confId) => _configs.watchConfig(confId);
}
