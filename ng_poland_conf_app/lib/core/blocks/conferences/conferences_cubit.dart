import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/usecases/usecases.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conference.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conferences.dart';
import 'package:ng_poland_conf_app/features/home/domains/usecases/get_all_conferences.dart';
import 'package:ng_poland_conf_app/features/home/presentation/conference_timer_mixin.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:collection/collection.dart';

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
    print('getConferences...');
    final Conferences? conferences = await getIt.get<GetAllConferences>().call(
          NoParams(),
        );

    if (conferences == null) return emit(const ConferencesState.error('error'));

    _conferences = conferences;
    print('getConferences... ${conferences.list.first.confId}');

    final Conference newestConference = conferences.list.first;

    if (selectedConference == null) {
      _setConference(newestConference);
    }

    emit(
      ConferencesState.loaded(
        conferences: conferences,
        selectedConference: selectedConference ?? newestConference,
      ),
    );
  }

  void _setConference(Conference selectedConference) {
    this.selectedConference = selectedConference;

    setTimer(selectedConference.conferencesStartDate);
  }
}
