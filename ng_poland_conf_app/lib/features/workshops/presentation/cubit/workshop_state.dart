part of 'workshop_cubit.dart';

@freezed
class WorkShopState with _$WorkShopState {
  const factory WorkShopState.initial() = _Initial;

  const factory WorkShopState.loading() = _Loading;

  const factory WorkShopState.loaded({
    required List<WorkShop> listWorkshop,
  }) = _Loaded;

  const factory WorkShopState.error(String error) = _Error;
}
