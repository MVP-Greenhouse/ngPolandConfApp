import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/features/event/domains/usecases/get_rate_for_event.dart';
import 'package:ng_poland_conf_app/features/event/domains/usecases/rate_event.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conference.dart';

part 'event_rating_event.dart';
part 'event_rating_state.dart';
part 'event_rating_bloc.freezed.dart';

@injectable
class EventRatingBloc extends Bloc<EventRatingEvent, EventRatingState> {
  final ConferencesCubit conferencesCubit;
  final GetRateForEvent getRateForEvent;
  final RateEvent rateEvent;
  final String eventId;
  final String eventItemType;

  Conference? get _selectedConference => conferencesCubit.state.mapOrNull(
        loaded: (value) => value.selectedConference,
      );

  EventRatingBloc(
    this.conferencesCubit,
    this.getRateForEvent,
    this.rateEvent,
    this.eventId,
    this.eventItemType,
  ) : super(const _Initial()) {
    on<_GetRateForEvent>(_onGetRateForEvent);
    on<_RateEvent>(
      _onRateEvent,
      transformer: droppable(),
    );
  }

  Future<void> _onGetRateForEvent(
    _GetRateForEvent event,
    Emitter<EventRatingState> emit,
  ) async {
    try {
      String? confId = _selectedConference?.confId;
      if (confId == null) return;
      emit(const EventRatingState.loading());
      final int? rate = await getRateForEvent(
        GetRateForEventParams(
          confId: confId,
          eventId: eventId,
          eventItemType: eventItemType,
        ),
      );
      if (rate != null) {
        emit(
          EventRatingState.rated(
            rateForEvent: rate,
          ),
        );
        return;
      }
      emit(const EventRatingState.readyToRate());
    } catch (_) {
      emit(const EventRatingState.failure());
    }
  }

  Future<void> _onRateEvent(
    _RateEvent event,
    Emitter<EventRatingState> emit,
  ) async {
    String? confId = _selectedConference?.confId;
    if (confId == null) return;
    emit(const EventRatingState.loading());
    try {
      int? rate;
      rate = await rateEvent(
        RateEventParams(
          confId: confId,
          eventId: eventId,
          eventItemType: eventItemType,
          rate: event.rate,
        ),
      );
      if (rate != null) {
        emit(
          EventRatingState.rated(
            rateForEvent: rate,
          ),
        );
      } else {
        rate = await getRateForEvent(
          GetRateForEventParams(
            confId: confId,
            eventId: eventId,
            eventItemType: eventItemType,
          ),
        );
        if (rate != null) {
          emit(
            EventRatingState.rated(
              rateForEvent: rate,
            ),
          );
          return;
        }
        emit(const EventRatingState.readyToRate());
      }
    } catch (_) {
      emit(const EventRatingState.failure());
    }
  }
}
