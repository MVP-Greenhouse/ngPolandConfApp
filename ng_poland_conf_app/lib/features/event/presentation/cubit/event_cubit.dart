import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/event/domains/usecases/get_event.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/entities/event_item.dart';

part 'event_state.dart';
part 'event_cubit.freezed.dart';

@injectable
class EventCubit extends Cubit<EventState> {
  EventCubit(this.getEvent) : super(const EventState.initial());

  final GetEvent getEvent;

  Future<void> getData({
    required String eventId,
    required String eventItemType,
  }) async {
    try {
      emit(const EventState.loading());
      final eventItem = await getEvent(
        Params(eventId: eventId, eventItemType: eventItemType),
      );
      emit(EventState.loaded(eventItem: eventItem));
    } catch (_) {
      emit(const EventState.error('Something went wrong'));
    }
  }
}
