part of 'conferences_cubit.dart';

@freezed
class ConferencesState with _$ConferencesState {
  const factory ConferencesState.initial() = _Initial;

  const factory ConferencesState.loaded(Conferences conferences) = _Loaded;
}
