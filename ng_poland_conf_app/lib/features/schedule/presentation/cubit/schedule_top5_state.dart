part of 'schedule_top5_cubit.dart';

sealed class ScheduleTop5State {
  const ScheduleTop5State();

  const factory ScheduleTop5State.hidden() = _Hidden;
  const factory ScheduleTop5State.loading() = _Loading;
  const factory ScheduleTop5State.empty({
    required EventItemType track,
    required String confId,
    required bool votingOpen,
    Set<String> myLikedEventIds,
  }) = _Empty;
  const factory ScheduleTop5State.loaded({
    required List<EventVoteRank> top,
    required EventItemType track,
    required String confId,
    required bool votingOpen,
    Set<String> myLikedEventIds,
  }) = _Loaded;
}

final class _Hidden extends ScheduleTop5State {
  const _Hidden();
}

final class _Loading extends ScheduleTop5State {
  const _Loading();
}

final class _Empty extends ScheduleTop5State {
  const _Empty({
    required this.track,
    required this.confId,
    required this.votingOpen,
    this.myLikedEventIds = const <String>{},
  });

  final EventItemType track;
  final String confId;
  final bool votingOpen;
  final Set<String> myLikedEventIds;
}

final class _Loaded extends ScheduleTop5State {
  const _Loaded({
    required this.top,
    required this.track,
    required this.confId,
    required this.votingOpen,
    this.myLikedEventIds = const <String>{},
  });

  final List<EventVoteRank> top;
  final EventItemType track;
  final String confId;
  final bool votingOpen;
  final Set<String> myLikedEventIds;
}

extension ScheduleTop5StateX on ScheduleTop5State {
  bool get isVotingOpen => switch (this) {
    _Empty(:final votingOpen) => votingOpen,
    _Loaded(:final votingOpen) => votingOpen,
    _ => false,
  };

  T maybeWhen<T>({
    T Function()? hidden,
    T Function()? loading,
    T Function(
      EventItemType track,
      String confId,
      bool votingOpen,
      Set<String> myLikedEventIds,
    )?
    empty,
    T Function(
      List<EventVoteRank> top,
      EventItemType track,
      String confId,
      bool votingOpen,
      Set<String> myLikedEventIds,
    )?
    loaded,
    required T Function() orElse,
  }) {
    return switch (this) {
      _Hidden() when hidden != null => hidden(),
      _Loading() when loading != null => loading(),
      _Empty(
        :final track,
        :final confId,
        :final votingOpen,
        :final myLikedEventIds,
      )
          when empty != null =>
        empty(track, confId, votingOpen, myLikedEventIds),
      _Loaded(
        :final top,
        :final track,
        :final confId,
        :final votingOpen,
        :final myLikedEventIds,
      )
          when loaded != null =>
        loaded(top, track, confId, votingOpen, myLikedEventIds),
      _ => orElse(),
    };
  }
}
