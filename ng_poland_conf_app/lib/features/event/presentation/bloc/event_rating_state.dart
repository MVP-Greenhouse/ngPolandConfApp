part of 'event_rating_bloc.dart';

@freezed
class EventRatingState with _$EventRatingState {
  const factory EventRatingState.initial() = _Initial;
  const factory EventRatingState.loading() = _Loading;
  const factory EventRatingState.readyToRate() = _ReadyToRate;
  const factory EventRatingState.rated({
    required int rateForEvent,
  }) = _Rated;
  const factory EventRatingState.failure() = _Failure;
}
