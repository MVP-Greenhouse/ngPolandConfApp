part of 'speakers_cubit.dart';

@freezed
class SpeakersState with _$SpeakersState {
  const factory SpeakersState.initial() = _Initial;

  const factory SpeakersState.loading() = _Loading;

  const factory SpeakersState.loaded({
    required List<Speaker> listSpeakers,
  }) = _Loaded;

  const factory SpeakersState.error(String error) = _Error;
}
