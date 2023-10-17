import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conference.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/entities/event_item.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/usecases/get_all_events_for_conference.dart';

part 'schedule_state.dart';
part 'schedule_cubit.freezed.dart';

@injectable
class ScheduleCubit extends Cubit<ScheduleState> {
  final ConferencesCubit conferencesCubit;
  final GetAllEventsForConference getAllEventsForConference;

  ScheduleCubit({
    required this.conferencesCubit,
    required this.getAllEventsForConference,
  }) : super(const ScheduleState.initial());

  Future<void> getListEvents({
    required EventItemType eventItemType,
  }) async {
    emit(const ScheduleState.loading());
    // delay for 1s for better UX
    await Future.delayed(const Duration(milliseconds: 500));
    final Conference? conference = conferencesCubit.selectedConference;

    if (conference == null) return;

    List<EventItem> listEvents = await getAllEventsForConference.call(
      Params(
        eventItemType: eventItemType.name,
        confId: conference.confId,
        limit: 10,
      ),
    );

    emit(ScheduleState.loaded(listEvents: listEvents));
  }
}
