import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/entities/track_engagement.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/usecases/watch_track_engagement.dart';

part 'schedule_voting_banner_state.dart';

@injectable
class ScheduleVotingBannerCubit extends Cubit<ScheduleVotingBannerState> {
  ScheduleVotingBannerCubit(this._watchTrackEngagement, this._logger)
    : super(const VotingBannerHidden());

  final WatchTrackEngagement _watchTrackEngagement;
  final Logger _logger;
  StreamSubscription<TrackEngagement>? _subscription;

  void load({required EventItemType track}) {
    unawaited(_subscription?.cancel());
    _subscription = _watchTrackEngagement(track).listen(
      (engagement) => emit(
        engagement.votingOpen || engagement.top5Enabled
            ? VotingBannerVisible(
                votingOpen: engagement.votingOpen,
                top5Enabled: engagement.top5Enabled,
              )
            : const VotingBannerHidden(),
      ),
      onError: (Object error, StackTrace stackTrace) {
        _logger.w(
          'Voting banner unavailable',
          error: error,
          stackTrace: stackTrace,
        );
        emit(const VotingBannerHidden());
      },
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
