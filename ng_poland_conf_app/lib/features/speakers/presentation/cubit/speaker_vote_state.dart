part of 'speaker_vote_cubit.dart';

@freezed
class SpeakerVoteState with _$SpeakerVoteState {
  const SpeakerVoteState._();

  const factory SpeakerVoteState.hidden() = _Hidden;
  const factory SpeakerVoteState.needsLogin() = _NeedsLogin;
  const factory SpeakerVoteState.ready(SpeakerVoteValue? vote) = _Ready;
  const factory SpeakerVoteState.saving(SpeakerVoteValue? vote) = _Saving;
  const factory SpeakerVoteState.failure(SpeakerVoteValue? vote) = _Failure;

  SpeakerVoteValue? get vote => maybeWhen(
    ready: (vote) => vote,
    saving: (vote) => vote,
    failure: (vote) => vote,
    orElse: () => null,
  );

  bool get showButtons => maybeWhen(hidden: () => false, orElse: () => true);
}
