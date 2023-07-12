import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/usecases/usecases.dart';
import 'package:ng_poland_conf_app/datasources/models/conferences.dart';
import 'package:ng_poland_conf_app/domains/usecases/get_newest_conferences.dart';
import 'package:ng_poland_conf_app/injectable.dart';

part 'conferences_state.dart';
part 'conferences_cubit.freezed.dart';

@singleton
class ConferencesCubit extends Cubit<ConferencesState> {
  ConferencesCubit() : super(const ConferencesState.initial());

  Future<void> getConferences() async {
    Conferences conferences = await getIt.get<GetNewestConference>().call(
          NoParams(),
        );

    emit(ConferencesState.loaded(conferences));
  }
}
