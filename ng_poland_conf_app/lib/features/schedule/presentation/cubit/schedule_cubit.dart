import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/edition/domain/exceptions/edition_unavailable_exception.dart';
import 'package:ng_poland_conf_app/features/schedule/domain/entities/track_schedule.dart';
import 'package:ng_poland_conf_app/features/schedule/domain/usecases/get_track_schedule.dart';

part 'schedule_state.dart';

@injectable
class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleCubit(this._getTrackSchedule, this._logger)
    : super(const ScheduleLoading(.ngPoland));

  final GetTrackSchedule _getTrackSchedule;
  final Logger _logger;

  Future<void> selectTrack(EventItemType track) async {
    emit(ScheduleLoading(track));
    try {
      final schedule = await _getTrackSchedule(track);
      if (!isClosed && state.track == track) {
        emit(ScheduleLoaded(track, schedule));
      }
    } on EditionUnavailableException catch (error, stackTrace) {
      _logger.w('Schedule unavailable', error: error, stackTrace: stackTrace);
      if (!isClosed) emit(ScheduleFailed(track));
    }
  }
}
