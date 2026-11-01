import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:ng_poland_conf_app/core/domain/app_exception.dart';
import 'package:ng_poland_conf_app/features/speakers/domain/entities/speaker_details.dart';
import 'package:ng_poland_conf_app/features/speakers/domain/usecases/get_speaker_details.dart';

part 'speaker_details_state.dart';

@injectable
class SpeakerDetailsCubit extends Cubit<SpeakerDetailsState> {
  SpeakerDetailsCubit(this._getSpeakerDetails, this._logger)
    : super(const SpeakerDetailsLoading());

  final GetSpeakerDetails _getSpeakerDetails;
  final Logger _logger;
  GetSpeakerDetailsParams? _params;

  Future<void> load(GetSpeakerDetailsParams params) async {
    _params = params;
    try {
      final details = await _getSpeakerDetails(params);
      if (!isClosed && _params == params) {
        emit(SpeakerDetailsLoaded(details, conference: params.conference));
      }
    } on AppException catch (error, stackTrace) {
      _logger.w('Speaker unavailable', error: error, stackTrace: stackTrace);
      if (!isClosed) emit(const SpeakerDetailsFailed());
    }
  }

  /// Shows another speaker of the same workshop.
  Future<void> selectSpeaker(String slug) async {
    if (_params case final params?) await load(params.withSlug(slug));
  }
}
