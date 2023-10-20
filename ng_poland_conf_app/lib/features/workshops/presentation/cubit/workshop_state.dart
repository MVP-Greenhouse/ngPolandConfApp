part of 'workshop_cubit.dart';

@freezed
class WorkshopState with _$WorkshopState {
  const factory WorkshopState.initial() = _Initial;

  const factory WorkshopState.loading() = _Loading;

  const factory WorkshopState.loaded({
    required List<Workshop> listWorkshop,
  }) = _Loaded;

  const factory WorkshopState.error(String error) = _Error;
}
