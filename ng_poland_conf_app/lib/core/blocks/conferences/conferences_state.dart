part of 'conferences_cubit.dart';

@freezed
class ConferencesState with _$ConferencesState {
  const factory ConferencesState.initial() = _Initial;

  const factory ConferencesState.loaded({
    required Conferences conferences,
    required Conference selectedConference,
  }) = _Loaded;

  const factory ConferencesState.error(String error) = _Error;
}
