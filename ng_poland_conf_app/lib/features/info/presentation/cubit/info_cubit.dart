import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conference.dart';
import 'package:ng_poland_conf_app/features/info/domains/entities/info_item.dart';
import 'package:ng_poland_conf_app/features/info/domains/usecases/get_all_info_items_for_conference.dart';

part 'info_state.dart';
part 'info_cubit.freezed.dart';

@injectable
class InfoCubit extends Cubit<InfoState> {
  final ConferencesCubit conferencesCubit;
  final GetAllInfoItemsForConference getAllSpeakerGetAllInfoItemsForConference;

  InfoCubit({
    required this.conferencesCubit,
    required this.getAllSpeakerGetAllInfoItemsForConference,
  }) : super(const InfoState.initial());

  Future<void> getListInfoItems() async {
    final Conference? conference = conferencesCubit.selectedConference;

    if (conference == null) return;

    List<InfoItem> listInfoItems = await getAllSpeakerGetAllInfoItemsForConference.call(
      Params(
        confId: conference.confId,
        limit: 10,
      ),
    );

    emit(InfoState.loaded(listInfoItems: listInfoItems));
  }
}
