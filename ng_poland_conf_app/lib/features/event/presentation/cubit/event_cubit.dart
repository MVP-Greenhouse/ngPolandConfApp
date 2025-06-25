import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/features/event/domains/usecases/get_event.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conference.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/entities/event_item.dart';

part 'event_state.dart';
part 'event_cubit.freezed.dart';

@injectable
class EventCubit extends Cubit<EventState> {
  final ConferencesCubit conferencesCubit;
  final GetEvent getEvent;

  EventCubit({
    required this.conferencesCubit,
    required this.getEvent,
  }) : super(const EventState.initial());

  Future<void> getData({
    required String eventId,
    required String eventItemType,
  }) async {
    try {
      emit(const EventState.loading());
      Conference? conference = conferencesCubit.selectedConference;
      if (conference == null) {
        await conferencesCubit.getConferences();
        conference = conferencesCubit.selectedConference;
      }
      if (conference == null) return emit(const EventState.error('Wystąpił problem'));
      final EventItem eventItem = await getEvent(
        Params(
          eventId: eventId,
          confId: conference.confId,
          eventItemType: eventItemType,
          limit: 1,
        ),
      );
      emit(
        EventState.loaded(
          eventItem: eventItem,
        ),
      );
    } catch (_) {
      emit(const EventState.error('Wystąpił problem'));
    }
  }
}
