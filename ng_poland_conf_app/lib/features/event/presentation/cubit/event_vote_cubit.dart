import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/entities/event_vote_status.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/exceptions/engagement_exception.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/services/event_vote_toggle.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/usecases/cast_event_vote.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/usecases/watch_event_vote.dart';

part 'event_vote_cubit.freezed.dart';
part 'event_vote_state.dart';

@injectable
class EventVoteCubit extends Cubit<EventVoteState> {
  EventVoteCubit(
    WatchEventVote watchEventVote,
    this._castEventVote,
    this._logger,
    @factoryParam this.eventId,
    @factoryParam EventItemType track,
  ) : super(const EventVoteState.hidden()) {
    _subscription = watchEventVote(
      WatchEventVoteParams(eventId: eventId, track: track),
    ).listen(_onStatus, onError: _onError);
  }

  final CastEventVote _castEventVote;
  final Logger _logger;
  final String eventId;
  late final StreamSubscription<EventVoteStatus> _subscription;

  bool get requiresLogin => state is VoteNeedsLogin;

  void _onStatus(EventVoteStatus status) {
    // A snapshot arriving mid-save would overwrite the optimistic state.
    final inFlight = state is VoteSaving || state is VoteFailure;
    if (inFlight && status is EventVoteAvailable) return;
    emit(switch (status) {
      EventVoteHidden() => const EventVoteState.hidden(),
      EventVoteNeedsLogin() => const EventVoteState.needsLogin(),
      EventVoteAvailable(:final liked) => EventVoteState.ready(liked),
    });
  }

  void _onError(Object error, StackTrace stackTrace) {
    _logger.w(
      'Event vote: status unavailable',
      error: error,
      stackTrace: stackTrace,
    );
    emit(const EventVoteState.hidden());
  }

  Future<void> toggleLike() async {
    final previous = switch (state) {
      VoteReady(:final vote) || VoteFailure(:final vote) => vote,
      _ => null,
    };
    if (previous == null) return;

    final next = EventVoteToggle.apply(currentlyLiked: previous);
    emit(EventVoteState.saving(previous));
    try {
      await _castEventVote(CastEventVoteParams(eventId: eventId, liked: next));
      if (!isClosed) emit(EventVoteState.ready(next));
    } on EngagementException catch (error, stackTrace) {
      _logger.w(
        'Event vote: saving failed',
        error: error,
        stackTrace: stackTrace,
      );
      if (!isClosed) emit(EventVoteState.failure(previous));
    }
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
