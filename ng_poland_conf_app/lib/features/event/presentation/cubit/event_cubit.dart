import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:ng_poland_conf_app/core/domain/app_exception.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/edition/domain/services/rich_text.dart';
import 'package:ng_poland_conf_app/features/event/domain/usecases/get_event.dart';

part 'event_state.dart';

@injectable
class EventCubit extends Cubit<EventState> {
  EventCubit(this._getEvent, this._logger) : super(const EventLoading());

  final GetEvent _getEvent;
  final Logger _logger;

  Future<void> load({
    required String eventId,
    required EventItemType track,
  }) async {
    emit(const EventLoading());
    try {
      final event = await _getEvent(
        GetEventParams(eventId: eventId, track: track),
      );
      emit(
        EventLoaded(
          event: event,
          hasDescription: hasVisibleText(
            html: event.descriptionHtml,
            plain: event.description ?? '',
          ),
        ),
      );
    } on AppException catch (error, stackTrace) {
      _logger.w('Event unavailable', error: error, stackTrace: stackTrace);
      emit(EventFailed(error.message));
    }
  }
}
