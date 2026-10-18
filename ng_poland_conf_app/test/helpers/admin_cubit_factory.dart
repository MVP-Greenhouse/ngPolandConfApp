import 'package:ng_poland_conf_app/features/admin/presentation/cubit/admin_cubit.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/watch_user_session.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/usecases/load_vote_ranking.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/usecases/sync_votable_events.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/usecases/update_track_engagement_config.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/usecases/watch_engagement_config.dart';
import 'package:ng_poland_conf_app/features/home/domain/usecases/watch_current_conference.dart';

import 'fakes.dart';

/// Builds an [AdminCubit] on real use cases over fake repositories.
AdminCubit buildAdminCubit({
  required FakeUserSessionRepository sessions,
  required FakeConferenceRepository conferences,
  required FakeEngagementConfigRepository configs,
  FakeEditionRepository? editions,
  FakeVotableEventRepository? votableEvents,
}) {
  final editionRepository = editions ?? FakeEditionRepository();
  final votable = votableEvents ?? FakeVotableEventRepository();
  return AdminCubit(
    WatchUserSession(sessions),
    WatchCurrentConference(conferences),
    WatchEngagementConfig(configs),
    LoadVoteRanking(editionRepository, FakeEventVoteRepository(), votable),
    UpdateTrackEngagementConfig(configs),
    SyncVotableEvents(editionRepository, votable),
    silentLogger,
  );
}
