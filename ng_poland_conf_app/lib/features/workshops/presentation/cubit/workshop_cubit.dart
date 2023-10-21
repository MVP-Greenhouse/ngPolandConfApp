import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conference.dart';
import 'package:ng_poland_conf_app/features/workshops/domains/entities/workshop.dart';
import 'package:ng_poland_conf_app/features/workshops/domains/usecases/get_workshops_for_conference.dart';

part 'workshop_state.dart';
part 'workshop_cubit.freezed.dart';

@injectable
class WorkshopCubit extends Cubit<WorkshopState> {
  final ConferencesCubit conferencesCubit;
  final GetWorkshopsForConference getWorkshopsForConference;

  WorkshopCubit({
    required this.conferencesCubit,
    required this.getWorkshopsForConference,
  }) : super(const WorkshopState.initial());

  Future<void> getListWorkshop({
    required EventItemType eventItemType,
  }) async {
    emit(const WorkshopState.loading());
    // delay for 1s for better UX
    await Future.delayed(const Duration(milliseconds: 500));
    Conference? conference = conferencesCubit.selectedConference;

    if (conference == null) {
      await conferencesCubit.getConferences();
      conference = conferencesCubit.selectedConference;
    }

    List<Workshop> listWorkshop = await getWorkshopsForConference.call(
      Params(
        eventItemType: eventItemType.name,
        confId: conference!.confId,
        limit: 10,
      ),
    );

    emit(WorkshopState.loaded(listWorkshop: listWorkshop));
  }
}
