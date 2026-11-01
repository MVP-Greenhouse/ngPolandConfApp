import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/get_user_session.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/entities/top5_board.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/exceptions/engagement_exception.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/services/event_vote_toggle.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/services/votable_event_catalog.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/usecases/cast_event_vote.dart';
import 'package:ng_poland_conf_app/features/engagement/domain/usecases/watch_top5.dart';

part 'schedule_top5_state.dart';

@injectable
class ScheduleTop5Cubit extends Cubit<ScheduleTop5State> {
  ScheduleTop5Cubit(
    this._watchTop5,
    this._castEventVote,
    this._getUserSession,
    this._logger,
  ) : super(const Top5StateLoading());

  final WatchTop5 _watchTop5;
  final CastEventVote _castEventVote;
  final GetUserSession _getUserSession;
  final Logger _logger;
  StreamSubscription<Top5Status>? _subscription;

  bool get requiresLogin => _getUserSession().profile == null;

  void load({required EventItemType track}) {
    unawaited(_subscription?.cancel());
    emit(const Top5StateLoading());
    _subscription = _watchTop5(track).listen(
      (status) => emit(switch (status) {
        Top5Hidden() => const Top5StateHidden(),
        Top5Loading() => const Top5StateLoading(),
        final Top5Board board => Top5Ready(board),
      }),
      onError: (Object error, StackTrace stackTrace) {
        _logger.w('Top 5 unavailable', error: error, stackTrace: stackTrace);
        emit(const Top5StateHidden());
      },
    );
  }

  /// Toggles the vote optimistically. Returns `false` when it was rejected.
  Future<bool> toggleLike(String eventId) async {
    final board = switch (state) {
      Top5Ready(:final board) when board.votingOpen => board,
      _ => null,
    };
    if (board == null || requiresLogin) return true;

    final votedByMe = board.myVotes.contains(eventId);
    final endsAt = board.top
        .where((entry) => entry.eventId == eventId)
        .firstOrNull
        ?.endsAt;
    if (!canToggleVote(
      votedByMe: votedByMe,
      endsAt: endsAt,
      now: DateTime.now(),
    )) {
      return true;
    }

    final liked = EventVoteToggle.apply(currentlyLiked: votedByMe);
    emit(Top5Ready(_withVote(board, eventId, liked: liked)));
    try {
      await _castEventVote(CastEventVoteParams(eventId: eventId, liked: liked));
      return true;
    } on EngagementException catch (error, stackTrace) {
      _logger.w(
        'Top 5: saving vote failed',
        error: error,
        stackTrace: stackTrace,
      );
      if (!isClosed) emit(Top5Ready(board));
      return false;
    }
  }

  static Top5Board _withVote(
    Top5Board board,
    String eventId, {
    required bool liked,
  }) {
    final wasLiked = board.myVotes.contains(eventId);
    return Top5Board(
      confId: board.confId,
      track: board.track,
      votingOpen: board.votingOpen,
      myVotes: liked ? {...board.myVotes, eventId} : {...board.myVotes}
        ..remove(eventId),
      top: [
        for (final entry in board.top)
          if (entry.eventId == eventId)
            entry.withLikes(
              nextOptimisticLikes(
                liked: liked,
                wasLiked: wasLiked,
                currentLikes: entry.likes,
              ),
            )
          else
            entry,
      ],
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
