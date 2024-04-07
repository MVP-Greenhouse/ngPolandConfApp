part of 'speaker_rating_bloc.dart';

@freezed
class SpeakerRatingEvent with _$SpeakerRatingEvent {
  const factory SpeakerRatingEvent.getRateForSpeaker() = _GetRateForSpeaker;

  const factory SpeakerRatingEvent.rateSpeaker({
    required int rate,
  }) = _RateSpeaker;
}
