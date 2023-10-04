import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conference.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/entities/speaker.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/usecases/get_all_speakers_for_conference.dart';

part 'speakers_state.dart';
part 'speakers_cubit.freezed.dart';

@injectable
class SpeakersCubit extends Cubit<SpeakersState> {
  final ConferencesCubit conferencesCubit;
  final GetAllSpeakersForConference getAllSpeakerGetAllSpeakersForConference;

  SpeakersCubit({
    required this.conferencesCubit,
    required this.getAllSpeakerGetAllSpeakersForConference,
  }) : super(const SpeakersState.initial());

  Future<void> getListSpeakers() async {
    final Conference? conference = conferencesCubit.selectedConference;

    if (conference == null) return;

    List<Speaker> listSpeakers = await getAllSpeakerGetAllSpeakersForConference.call(
      Params(
        confId: conference.confId,
        limit: 10,
      ),
    );

    emit(SpeakersState.loaded(listSpeakers: listSpeakers));
  }
}