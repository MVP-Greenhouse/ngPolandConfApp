import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:ng_poland_conf_app/features/edition/domain/exceptions/edition_unavailable_exception.dart';
import 'package:ng_poland_conf_app/features/workshops/domain/entities/workshop_day.dart';
import 'package:ng_poland_conf_app/features/workshops/domain/usecases/get_workshop_days.dart';

part 'workshops_state.dart';

@injectable
class WorkshopsCubit extends Cubit<WorkshopsState> {
  WorkshopsCubit(this._getWorkshopDays, this._logger)
    : super(const WorkshopsLoading());

  final GetWorkshopDays _getWorkshopDays;
  final Logger _logger;
  List<WorkshopDay>? _days;
  String? _requestedDayKey;
  int? _pendingScrollId;

  Future<void> load() async {
    try {
      _days = await _getWorkshopDays();
      _emitLoaded();
    } on EditionUnavailableException catch (error, stackTrace) {
      _logger.w('Workshops unavailable', error: error, stackTrace: stackTrace);
      if (!isClosed) emit(const WorkshopsFailed());
    }
  }

  /// Opens [dayKey] and / or scrolls to [workshopId] (deep links).
  void focus({String? dayKey, int? workshopId}) {
    _requestedDayKey = dayKey ?? _requestedDayKey;
    _pendingScrollId = workshopId;
    _emitLoaded();
  }

  void selectDay(String key) {
    _requestedDayKey = key;
    _pendingScrollId = null;
    _emitLoaded();
  }

  void scrollHandled() {
    _pendingScrollId = null;
    _emitLoaded();
  }

  void _emitLoaded() {
    final days = _days;
    if (days == null || isClosed) return;
    final pending = _pendingScrollId;
    final selected =
        days.firstWhereOrNull(
          (day) => pending != null && day.contains(pending),
        ) ??
        days.firstWhereOrNull((day) => day.key == _requestedDayKey) ??
        days.firstOrNull;
    emit(
      WorkshopsLoaded(
        days: days,
        selected: selected,
        pendingScrollId:
            selected != null && pending != null && selected.contains(pending)
            ? pending
            : null,
      ),
    );
  }
}
