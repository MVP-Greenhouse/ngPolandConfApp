part of 'event_rating_bloc.dart';

@freezed
class EventRatingEvent with _$EventRatingEvent {
  const factory EventRatingEvent.getRateForEvent() = _GetRateForEvent;

  const factory EventRatingEvent.rateEvent({
    required int rate,
  }) = _RateEvent;
}
