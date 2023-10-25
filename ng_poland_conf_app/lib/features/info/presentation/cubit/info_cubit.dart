import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conference.dart';
import 'package:ng_poland_conf_app/features/info/domains/entities/info_item.dart';
import 'package:ng_poland_conf_app/features/info/domains/usecases/get_all_info_items_for_conference.dart';
import 'package:ng_poland_conf_app/injectable.dart';

import '../../domains/usecases/query_info_items.dart';
import '../../domains/usecases/save_info_items.dart';

part 'info_state.dart';
part 'info_cubit.freezed.dart';

@injectable
class InfoCubit extends Cubit<InfoState> {
  final ConferencesCubit conferencesCubit;
  final GetAllInfoItemsForConference getAllInfoItems;
  final QueryInfoItems queryAllInfoItems;

  InfoCubit(
    this.queryAllInfoItems, {
    required this.conferencesCubit,
    required this.getAllInfoItems,
  }) : super(const InfoState.initial());

  Future<void> getListInfoItems() async {
    emit(const InfoState.loading());
    Conference? conference = conferencesCubit.selectedConference;

    if (conference == null) {
      await conferencesCubit.queryConferences();
      conference = conferencesCubit.selectedConference;
      return;
    }

    List<InfoItem> listInfoItems = await getAllInfoItems.call();

    emit(InfoState.loaded(listInfoItems: listInfoItems));
  }

  Future<void> queryInfoItems() async {
    emit(const InfoState.loading());
    Conference? conference = conferencesCubit.selectedConference;

    if (conference == null) {
      await conferencesCubit.queryConferences();
      conference = conferencesCubit.selectedConference;
    }

    List<InfoItem> listInfoItems = await queryAllInfoItems.call(
      Params(
        confId: conference!.confId,
        limit: 10,
      ),
    );

    if (listInfoItems.isNotEmpty) {
      await getIt.get<SaveInfoItems>().call(SaveInfoItemsParams(infoItems: listInfoItems));
      await getListInfoItems();
    }
  }
}
