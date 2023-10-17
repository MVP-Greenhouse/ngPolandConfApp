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
class WorkShopCubit extends Cubit<WorkShopState> {
  final ConferencesCubit conferencesCubit;
  final GetWorkshopsForConference getWorkshopsForConference;

  WorkShopCubit({
    required this.conferencesCubit,
    required this.getWorkshopsForConference,
  }) : super(const WorkShopState.initial());

  Future<void> getListWorkshop({
    required EventItemType eventItemType,
  }) async {
    emit(const WorkShopState.loading());
    // delay for 1s for better UX
    await Future.delayed(const Duration(milliseconds: 500));
    final Conference? conference = conferencesCubit.selectedConference;

    if (conference == null) return;

    List<WorkShop> listWorkshop = await getWorkshopsForConference.call(
      Params(
        eventItemType: eventItemType.name,
        confId: conference.confId,
        limit: 10,
      ),
    );

    emit(WorkShopState.loaded(listWorkshop: listWorkshop));
  }
}
