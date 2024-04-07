part of 'speaker_rating_bloc.dart';

@freezed
class SpeakerRatingState with _$SpeakerRatingState {
  const factory SpeakerRatingState.initial() = _Initial;
  const factory SpeakerRatingState.loading() = _Loading;
  const factory SpeakerRatingState.readyToRate() = _ReadyToRate;
  const factory SpeakerRatingState.rated({
    required int rateForSpeaker,
  }) = _Rated;
  const factory SpeakerRatingState.failure() = _Failure;
}
