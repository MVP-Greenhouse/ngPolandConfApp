import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/engagement_visibility.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/latest_conference_resolver.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/engagement_config_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'schedule_voting_banner_state.dart';

@injectable
class ScheduleVotingBannerCubit extends Cubit<ScheduleVotingBannerState> {
  ScheduleVotingBannerCubit(
    this._configRepository,
    this._conferencesCubit,
  ) : super(const ScheduleVotingBannerState.hidden());

  final EngagementConfigRepository _configRepository;
  final ConferencesCubit _conferencesCubit;
  final BehaviorSubject<EventItemType> _track$ =
      BehaviorSubject<EventItemType>.seeded(EventItemType.ngPoland);

  StreamSubscription<ScheduleVotingBannerState>? _subscription;

  void load({required EventItemType track}) {
    _track$.add(track);
    _subscription ??= Rx.combineLatest2(
          _conferencesCubit.stream.startWith(_conferencesCubit.state),
          _track$,
          (ConferencesState conferences, EventItemType track) =>
              (conferences: conferences, track: track),
        )
        .switchMap(_mapToState)
        .listen(
          (next) {
            if (!isClosed) emit(next);
          },
          onError: (_) {
            if (!isClosed) emit(const ScheduleVotingBannerState.hidden());
          },
        );
  }

  Stream<ScheduleVotingBannerState> _mapToState(
    ({ConferencesState conferences, EventItemType track}) snapshot,
  ) {
    final loaded = snapshot.conferences.mapOrNull(loaded: (state) => state);
    if (loaded == null) {
      return Stream.value(const ScheduleVotingBannerState.hidden());
    }

    final selectedConfId = loaded.selectedConference.confId;
    final latestConfId = LatestConferenceResolver.fromConfIds(
      loaded.conferences.list.map((conference) => conference.confId),
    );
    if (latestConfId == null) {
      return Stream.value(const ScheduleVotingBannerState.hidden());
    }

    return _configRepository.watchConfig(latestConfId).map((config) {
      final trackConfig = config.forTrack(snapshot.track);
      final votingOpen = EngagementVisibility.showVoting(
        selectedConfId: selectedConfId,
        latestConfId: latestConfId,
        votingOpen: trackConfig.isVotingOpen(DateTime.now()),
      );
      final top5Enabled = EngagementVisibility.showTop5(
        selectedConfId: selectedConfId,
        latestConfId: latestConfId,
        top5Enabled: trackConfig.top5Enabled,
      );
      if (!votingOpen && !top5Enabled) {
        return const ScheduleVotingBannerState.hidden();
      }
      return ScheduleVotingBannerState.visible(
        votingOpen: votingOpen,
        top5Enabled: top5Enabled,
      );
    });
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    await _track$.close();
    return super.close();
  }
}
