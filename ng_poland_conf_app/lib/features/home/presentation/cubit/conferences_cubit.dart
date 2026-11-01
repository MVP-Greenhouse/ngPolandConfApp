import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/conference.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/edition/domain/exceptions/edition_unavailable_exception.dart';
import 'package:ng_poland_conf_app/features/edition/domain/services/conference_tracks.dart';
import 'package:ng_poland_conf_app/features/home/domain/usecases/load_current_conference.dart';

part 'conferences_state.dart';

/// App-wide current conference, provided above the router.
@singleton
class ConferencesCubit extends Cubit<ConferencesState> {
  ConferencesCubit(this._loadCurrentConference, this._logger)
    : super(const ConferencesInitial());

  final LoadCurrentConference _loadCurrentConference;
  final Logger _logger;

  Future<void> load() async {
    try {
      emit(ConferencesLoaded(await _loadCurrentConference()));
    } on EditionUnavailableException catch (error, stackTrace) {
      _logger.w('Conference unavailable', error: error, stackTrace: stackTrace);
      if (state is! ConferencesLoaded) emit(const ConferencesFailed());
    }
  }
}
