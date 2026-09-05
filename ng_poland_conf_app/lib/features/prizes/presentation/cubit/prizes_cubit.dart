import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/user_session_cubit.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_history_entry.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_winner.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/engagement_config.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/user_prize.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/has_any_prize.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/latest_conference_resolver.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/user_prize_resolver.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/contest_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/engagement_config_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'prizes_state.dart';
part 'prizes_cubit.freezed.dart';

@lazySingleton
class PrizesCubit extends Cubit<PrizesState> {
  PrizesCubit(
    this._contestRepository,
    this._configRepository,
    this._userSessionCubit,
    this._conferencesCubit,
  ) : super(const PrizesState()) {
    _listen();
  }

  final ContestRepository _contestRepository;
  final EngagementConfigRepository _configRepository;
  final UserSessionCubit _userSessionCubit;
  final ConferencesCubit _conferencesCubit;

  StreamSubscription<PrizesState>? _subscription;

  void _listen() {
    final conferences$ = _conferencesCubit.stream.startWith(
      _conferencesCubit.state,
    );
    final session$ = _userSessionCubit.stream.startWith(
      _userSessionCubit.state,
    );

    _subscription =
        Rx.combineLatest2(
              conferences$,
              session$,
              (ConferencesState conferences, UserSessionState session) =>
                  (conferences: conferences, session: session),
            )
            .switchMap(_mapToState)
            .listen(
              (next) {
                if (!isClosed) emit(next);
              },
              onError: (_, _) {
                if (!isClosed) emit(const PrizesState(loading: false));
              },
            );
  }

  Stream<PrizesState> _mapToState(
    ({ConferencesState conferences, UserSessionState session}) snapshot,
  ) {
    final sessionLoading = snapshot.session.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );
    if (sessionLoading) return Stream.value(const PrizesState());

    final profile = snapshot.session.profile;
    if (profile == null) {
      return Stream.value(const PrizesState(loading: false));
    }

    final loaded = snapshot.conferences.mapOrNull(loaded: (state) => state);
    if (loaded == null) return Stream.value(const PrizesState());

    final latestConfId = LatestConferenceResolver.fromConfIds(
      loaded.conferences.list.map((conference) => conference.confId),
    );
    if (latestConfId == null) {
      return Stream.value(const PrizesState(loading: false));
    }

    return Rx.combineLatest3(
      _configRepository.watchConfig(latestConfId),
      _contestRepository.watchHistory(latestConfId),
      _contestRepository.watchMyWin(confId: latestConfId, uid: profile.uid),
      (
        EngagementConfig config,
        List<ContestHistoryEntry> history,
        ContestWinner? activeWin,
      ) {
        final prizes = UserPrizeResolver.resolve(
          uid: profile.uid,
          history: history,
          activeWin: activeWin,
          activeContestId: config.contestId,
          activeContestName: config.contestName.trim().isEmpty
              ? 'Konkurs'
              : config.contestName,
        );
        final historyWins = history
            .where(
              (entry) =>
                  entry.winners.any((winner) => winner.uid == profile.uid),
            )
            .length;
        return PrizesState(
          hasPrizes: HasAnyPrize.resolve(
            historyWins: historyWins,
            hasActiveWin: activeWin != null,
          ),
          prizes: prizes,
          loading: false,
        );
      },
    ).startWith(const PrizesState());
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
