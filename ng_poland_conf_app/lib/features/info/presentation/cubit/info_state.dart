part of 'info_cubit.dart';

@freezed
class InfoState with _$InfoState {
  const factory InfoState.initial() = _Initial;

  const factory InfoState.loading() = _Loading;

  const factory InfoState.loaded({
    required List<InfoItem> listInfoItems,
  }) = _Loaded;

  const factory InfoState.error(String error) = _Error;
}
