part of 'event_vote_cubit.dart';

@freezed
class EventVoteState with _$EventVoteState {
  const EventVoteState._();

  const factory EventVoteState.hidden() = _Hidden;
  const factory EventVoteState.needsLogin() = _NeedsLogin;
  const factory EventVoteState.ready(bool vote) = _Ready;
  const factory EventVoteState.saving(bool vote) = _Saving;
  const factory EventVoteState.failure(bool vote) = _Failure;

  bool get liked => maybeWhen(
    ready: (vote) => vote,
    saving: (vote) => vote,
    failure: (vote) => vote,
    orElse: () => false,
  );

  bool get showButton => maybeWhen(hidden: () => false, orElse: () => true);
}
