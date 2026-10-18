part of 'event_vote_cubit.dart';

@freezed
sealed class EventVoteState with _$EventVoteState {
  const EventVoteState._();

  const factory EventVoteState.hidden() = VoteHidden;

  const factory EventVoteState.needsLogin() = VoteNeedsLogin;

  const factory EventVoteState.ready(bool vote) = VoteReady;

  /// A vote change is being saved; [vote] is the value before the change.
  const factory EventVoteState.saving(bool vote) = VoteSaving;

  const factory EventVoteState.failure(bool vote) = VoteFailure;

  bool get liked => switch (this) {
    VoteReady(:final vote) ||
    VoteSaving(:final vote) ||
    VoteFailure(:final vote) => vote,
    VoteHidden() || VoteNeedsLogin() => false,
  };

  bool get showButton => this is! VoteHidden;
}
