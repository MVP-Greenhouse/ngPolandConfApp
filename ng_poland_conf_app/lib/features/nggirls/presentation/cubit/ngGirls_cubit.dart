import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conference.dart';
import 'package:ng_poland_conf_app/features/nggirls/domains/entities/ngGirls.dart';
import 'package:ng_poland_conf_app/features/nggirls/domains/usecases/get_ngGirls_for_conference.dart';

part 'ngGirls_state.dart';
part 'ngGirls_cubit.freezed.dart';

@injectable
class NgGirlsCubit extends Cubit<NgGirlsState> {
  final ConferencesCubit conferencesCubit;
  final GetNgGirlsForConference getNgGirlsForConference;

  NgGirlsCubit({
    required this.conferencesCubit,
    required this.getNgGirlsForConference,
  }) : super(const NgGirlsState.initial());

  Future<void> getNgGirls() async {
    final Conference? conference = conferencesCubit.selectedConference;

    if (conference == null) return;

    NgGirls ngGirls = await getNgGirlsForConference.call(
      Params(
        confId: conference.confId,
      ),
    );

    emit(NgGirlsState.loaded(ngGirls: ngGirls));
  }
}
