import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/usecases/get_rate_for_speaker.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/usecases/rate_speaker.dart';

part 'speaker_rating_event.dart';
part 'speaker_rating_state.dart';
part 'speaker_rating_bloc.freezed.dart';

@injectable
class SpeakerRatingBloc extends Bloc<SpeakerRatingEvent, SpeakerRatingState> {
  final ConferencesCubit conferencesCubit;
  final GetRateForSpeaker getRateForSpeaker;
  final RateSpeaker rateSpeaker;
  final String speakerId;

  SpeakerRatingBloc(
    this.conferencesCubit,
    this.getRateForSpeaker,
    this.rateSpeaker,
    this.speakerId,
  ) : super(const _Initial()) {
    on<_GetRateForSpeaker>(_onGetRateForSpeaker);
    on<_RateSpeaker>(
      _onRateSpeaker,
      transformer: droppable(),
    );
  }

  Future<void> _onGetRateForSpeaker(
    _GetRateForSpeaker event,
    Emitter<SpeakerRatingState> emit,
  ) async {
    try {
      String? confId = conferencesCubit.selectedConference?.confId;
      if (confId == null) return;
      emit(const _Loading());
      final int? rate = await getRateForSpeaker(
        GetRateForSpeakerParams(
          confId: confId,
          speakerId: speakerId,
        ),
      );
      if (rate != null) {
        emit(
          _Rated(
            rateForSpeaker: rate,
          ),
        );
        return;
      }
      emit(const _ReadyToRate());
    } catch (_) {
      emit(const _Failure());
    }
  }

  Future<void> _onRateSpeaker(
    _RateSpeaker event,
    Emitter<SpeakerRatingState> emit,
  ) async {
    String? confId = conferencesCubit.selectedConference?.confId;
    if (confId == null) return;
    emit(const _Loading());
    try {
      int? rate;
      rate = await rateSpeaker(
        RateSpeakerParams(
          confId: confId,
          speakerId: speakerId,
          rate: event.rate,
        ),
      );
      if (rate != null) {
        emit(
          _Rated(
            rateForSpeaker: rate,
          ),
        );
      } else {
        rate = await getRateForSpeaker(
          GetRateForSpeakerParams(
            confId: confId,
            speakerId: speakerId,
          ),
        );
        if (rate != null) {
          emit(
            _Rated(
              rateForSpeaker: rate,
            ),
          );
          return;
        }
        emit(const _ReadyToRate());
      }
    } catch (_) {
      emit(const _Failure());
    }
  }
}
