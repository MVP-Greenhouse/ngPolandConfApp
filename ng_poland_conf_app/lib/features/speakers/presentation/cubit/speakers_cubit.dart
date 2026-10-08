import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/edition/datasources/repositories/edition_repository.dart';
import 'package:ng_poland_conf_app/features/edition/domains/logic/edition_projections.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/entities/speaker.dart';

part 'speakers_state.dart';
part 'speakers_cubit.freezed.dart';

@injectable
class SpeakersCubit extends Cubit<SpeakersState> {
  SpeakersCubit(this._editions) : super(const SpeakersState.initial());

  final EditionRepository _editions;

  Future<void> getListSpeakers() async {
    emit(const SpeakersState.loading());
    final edition = await _editions.load();
    if (edition == null) {
      emit(const SpeakersState.error('error'));
      return;
    }
    emit(SpeakersState.loaded(listSpeakers: speakersFromEdition(edition)));
  }
}
