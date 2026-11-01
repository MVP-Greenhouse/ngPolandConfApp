import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:ng_poland_conf_app/features/edition/domain/exceptions/edition_unavailable_exception.dart';
import 'package:ng_poland_conf_app/features/info/domain/entities/venue_info.dart';
import 'package:ng_poland_conf_app/features/info/domain/usecases/get_venue_info.dart';

part 'info_state.dart';

@injectable
class InfoCubit extends Cubit<InfoState> {
  InfoCubit(this._getVenueInfo, this._logger) : super(const InfoLoading());

  final GetVenueInfo _getVenueInfo;
  final Logger _logger;

  Future<void> load() async {
    try {
      emit(InfoLoaded(await _getVenueInfo()));
    } on EditionUnavailableException catch (error, stackTrace) {
      _logger.w('Venue info unavailable', error: error, stackTrace: stackTrace);
      emit(const InfoFailed());
    }
  }
}
