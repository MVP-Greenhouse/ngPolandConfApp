import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/edition/datasources/repositories/edition_repository.dart';
import 'package:ng_poland_conf_app/features/edition/domains/logic/edition_projections.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/entities/event_item.dart';

part 'schedule_state.dart';
part 'schedule_cubit.freezed.dart';

@injectable
class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleCubit(this._editions) : super(const ScheduleState.initial());

  final EditionRepository _editions;

  Future<void> getListEvents({required EventItemType eventItemType}) async {
    emit(const ScheduleState.loading());

    final edition = await _editions.load();
    if (edition == null) {
      emit(const ScheduleState.error('error'));
      return;
    }

    emit(
      ScheduleState.loaded(
        listEvents: eventItemsForTrack(edition: edition, track: eventItemType),
      ),
    );
  }
}
