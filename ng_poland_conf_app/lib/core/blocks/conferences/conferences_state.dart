part of 'conferences_cubit.dart';

@freezed
class ConferencesState with _$ConferencesState {
  List<EventItemType> get availableEventTypes {
    final state = this;
    if (state is! _Loaded) return [];
    final int? confId = int.tryParse(state.selectedConference.confId);
    if (confId == null) return [];
    if (confId < 2025) {
      return [
        EventItemType.ngPoland,
        EventItemType.jsPoland,
      ];
    }
    return EventItemType.values;
  }

  bool get isCurrent =>
      mapOrNull(
        loaded: (value) => value.selectedConference.isCurrent,
      ) ??
      false;

  const factory ConferencesState.initial() = _Initial;

  const factory ConferencesState.loaded({
    required Conferences conferences,
    required Conference selectedConference,
  }) = _Loaded;

  const factory ConferencesState.error(String error) = _Error;

  const ConferencesState._();
}
