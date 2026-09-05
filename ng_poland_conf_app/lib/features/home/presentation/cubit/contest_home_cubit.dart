import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/user_session_cubit.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_participant.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/contest_winner.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/contest_home_view.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/latest_conference_resolver.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/contest_repository.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/repositories/engagement_config_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'contest_home_state.dart';
part 'contest_home_cubit.freezed.dart';

@injectable
class ContestHomeCubit extends Cubit<ContestHomeState> {
  ContestHomeCubit(
    this._contestRepository,
    this._configRepository,
    this._userSessionCubit,
    this._conferencesCubit,
  ) : super(const ContestHomeState()) {
    _listen();
  }

  final ContestRepository _contestRepository;
  final EngagementConfigRepository _configRepository;
  final UserSessionCubit _userSessionCubit;
  final ConferencesCubit _conferencesCubit;

  StreamSubscription<ContestHomeState>? _subscription;

  bool requiresLogin() => _userSessionCubit.state.maybeWhen(
    unauthenticated: () => true,
    orElse: () => false,
  );

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
                if (isClosed) return;
                if (state.joinFailed) {
                  emit(next.copyWith(joinFailed: true));
                  return;
                }
                emit(next);
              },
              onError: (_) {
                // Keep the last good ContestHomeState. Emitting a blank
                // ContestHomeState() would hide the CTA for the rest of
                // this Host lifetime after a transient stream error.
              },
            );
  }

  Stream<ContestHomeState> _mapToState(
    ({ConferencesState conferences, UserSessionState session}) snapshot,
  ) {
    final loaded = snapshot.conferences.mapOrNull(loaded: (state) => state);
    if (loaded == null) {
      return Stream.value(const ContestHomeState());
    }

    final selectedConfId = loaded.selectedConference.confId;
    final latestConfId = LatestConferenceResolver.fromConfIds(
      loaded.conferences.list.map((conference) => conference.confId),
    );
    if (latestConfId == null) {
      return Stream.value(const ContestHomeState());
    }

    final isLoadingSession = snapshot.session.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );
    final profile = snapshot.session.profile;

    return _configRepository.watchConfig(latestConfId).switchMap((config) {
      final isLatestConference = selectedConfId == latestConfId;

      if (!isLatestConference || isLoadingSession || profile == null) {
        return Stream.value(
          ContestHomeState(
            view: ContestHomeViewResolver.resolve(
              isLatestConference: isLatestConference,
              config: config,
              now: DateTime.now(),
              isParticipant: false,
              isWinner: false,
            ),
            latestConfId: latestConfId,
            contestId: config.contestId,
            profile: profile,
          ),
        );
      }

      return Rx.combineLatest2(
        _contestRepository.watchMyParticipation(
          confId: latestConfId,
          uid: profile.uid,
        ),
        _contestRepository.watchMyWin(confId: latestConfId, uid: profile.uid),
        (ContestParticipant? participant, ContestWinner? winner) =>
            ContestHomeState(
              view: ContestHomeViewResolver.resolve(
                isLatestConference: true,
                config: config,
                now: DateTime.now(),
                isParticipant: participant != null,
                isWinner: winner != null,
              ),
              latestConfId: latestConfId,
              contestId: config.contestId,
              profile: profile,
            ),
      );
    });
  }

  Future<void> join() async {
    if (requiresLogin()) return;

    final profile = state.profile ?? _userSessionCubit.state.profile;
    final confId = state.latestConfId;
    if (profile == null || confId == null) return;

    try {
      await _contestRepository.join(
        confId: confId,
        uid: profile.uid,
        displayName: profile.displayName,
        email: profile.email,
      );
    } catch (_) {
      if (!isClosed) emit(state.copyWith(joinFailed: true));
    }
  }

  void clearJoinFailed() {
    if (!isClosed && state.joinFailed) {
      emit(state.copyWith(joinFailed: false));
    }
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
