import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/edition/domain/exceptions/edition_unavailable_exception.dart';
import 'package:ng_poland_conf_app/features/speakers/domain/entities/speaker_list_item.dart';
import 'package:ng_poland_conf_app/features/speakers/domain/usecases/get_track_speakers.dart';

part 'speakers_state.dart';

@injectable
class SpeakersCubit extends Cubit<SpeakersState> {
  SpeakersCubit(this._getTrackSpeakers, this._logger)
    : super(const SpeakersLoading(.ngPoland));

  final GetTrackSpeakers _getTrackSpeakers;
  final Logger _logger;

  Future<void> selectTrack(EventItemType track) async {
    emit(SpeakersLoading(track));
    try {
      final speakers = await _getTrackSpeakers(track);
      if (!isClosed && state.track == track) {
        emit(SpeakersLoaded(track, speakers));
      }
    } on EditionUnavailableException catch (error, stackTrace) {
      _logger.w('Speakers unavailable', error: error, stackTrace: stackTrace);
      if (!isClosed) emit(SpeakersFailed(track));
    }
  }
}
