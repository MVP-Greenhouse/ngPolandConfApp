import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/features/home/domains/entities/conference.dart';
import 'package:ng_poland_conf_app/features/nggirls/domains/entities/ngGirls.dart';
import 'package:ng_poland_conf_app/features/nggirls/domains/usecases/get_ngGirls_for_conference.dart';
import 'package:ng_poland_conf_app/injectable.dart';

import '../../domains/usecases/query_ngGirls.dart';
import '../../domains/usecases/save_ngGirls.dart';

part 'ngGirls_state.dart';
part 'ngGirls_cubit.freezed.dart';

@injectable
class NgGirlsCubit extends Cubit<NgGirlsState> {
  final ConferencesCubit conferencesCubit;
  final GetNgGirlsForConference getNgGirlsForConference;
  final QueryNgGirls queryNgGirls;

  NgGirlsCubit(
    this.queryNgGirls, {
    required this.conferencesCubit,
    required this.getNgGirlsForConference,
  }) : super(const NgGirlsState.initial());

  Future<void> getNgGirls() async {
    emit(const NgGirlsState.loading());
    Conference? conference = conferencesCubit.selectedConference;

    if (conference == null) {
      await conferencesCubit.queryConferences();
      conference = conferencesCubit.selectedConference;
      return;
    }

    NgGirls ngGirls = await getNgGirlsForConference.call(
      Params(
        confId: conference.confId,
      ),
    );

    emit(NgGirlsState.loaded(ngGirls: ngGirls));
  }

  Future<void> query() async {
    emit(const NgGirlsState.loading());
    Conference? conference = conferencesCubit.selectedConference;

    if (conference == null) {
      await conferencesCubit.queryConferences();
      conference = conferencesCubit.selectedConference;
    }

    NgGirls? ngGirls = await queryNgGirls.call(
      NgGirlsQueryParams(
        confId: conference!.confId,
        limit: 1,
      ),
    );

    if (ngGirls != null) {
      await getIt.get<SaveNgGirls>().call(SaveNgGirlsParams(ngGirls: ngGirls));
      await getNgGirls();
    }
  }
}
