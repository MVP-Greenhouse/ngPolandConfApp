import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/domain/use_case.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/repositories/engagement_config_repository.dart';

@injectable
class UpdateTrackEngagementConfig
    implements UseCase<void, UpdateTrackEngagementConfigParams> {
  const UpdateTrackEngagementConfig(this._configs);

  final EngagementConfigRepository _configs;

  @override
  Future<void> call(UpdateTrackEngagementConfigParams params) =>
      _configs.saveTrackConfig(
        confId: params.confId,
        track: params.track,
        config: params.config,
      );
}

class UpdateTrackEngagementConfigParams {
  const UpdateTrackEngagementConfigParams({
    required this.confId,
    required this.track,
    required this.config,
  });

  final String confId;
  final EventItemType track;
  final TrackEngagementConfig config;
}
