// ignore_for_file: file_names

part of 'ngGirls_cubit.dart';

@freezed
class NgGirlsState with _$NgGirlsState {
  const factory NgGirlsState.initial() = _Initial;

  const factory NgGirlsState.loading() = _Loading;

  const factory NgGirlsState.loaded({
    required NgGirls ngGirls,
  }) = _Loaded;

  const factory NgGirlsState.error(String error) = _Error;
}
