import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/usecases/usecases.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conference.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conferences.dart';
import 'package:ng_poland_conf_app/features/home/domains/usecases/get_all_conferences.dart';
import 'package:ng_poland_conf_app/features/home/domains/usecases/query_conferences.dart';
import 'package:ng_poland_conf_app/features/home/presentation/conference_timer_mixin.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:collection/collection.dart';

import '../../../features/home/domains/usecases/save_conferences.dart';

part 'conferences_state.dart';
part 'conferences_cubit.freezed.dart';

@singleton
class ConferencesCubit extends Cubit<ConferencesState> with ConferenceTimerMixin {
  Conferences? _conferences;
  Conference? selectedConference;

  ConferencesCubit() : super(const ConferencesState.initial());

  Future<void> changeConference(String confId) async {
    final Conferences? conferences = _conferences;
    final Conference? selectedConference = _conferences?.list.firstWhereOrNull(
      (conference) => conference.confId == confId,
    );

    if (conferences != null && selectedConference != null) {
      _setConference(selectedConference);

      emit(
        ConferencesState.loaded(
          conferences: conferences,
          selectedConference: selectedConference,
        ),
      );
    }
  }

  Future<void> getConferences() async {
    final Conferences? conferences = await getIt.get<GetAllConferences>().call(
          NoParams(),
        );

    if (conferences == null || conferences.list.isEmpty) {
      emit(const ConferencesState.error('Error while loading conferences'));
      return;
    }

    _conferences = conferences;

    final Conference newestConference = conferences.list.first;

    if (selectedConference == null) {
      _setConference(newestConference);
    }

    // await getIt.get<SaveConferences>().call(Params(confs: conferences));

    emit(
      ConferencesState.loaded(
        conferences: conferences,
        selectedConference: selectedConference ?? newestConference,
      ),
    );
  }

  Future<void> queryConferences() async {
    final Conferences? conferences = await getIt.get<QueryConferences>().call(
          NoParams(),
        );
    if (conferences != null) {
      await getIt.get<SaveConferences>().call(Params(confs: conferences));
      await getConferences();
    }
  }

  void _setConference(Conference selectedConference) {
    this.selectedConference = selectedConference;

    setTimer(selectedConference.conferencesStartDate);
  }
}
