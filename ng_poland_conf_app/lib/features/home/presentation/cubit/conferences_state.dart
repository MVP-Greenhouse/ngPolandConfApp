part of 'conferences_cubit.dart';

sealed class ConferencesState {
  const ConferencesState();

  Conference? get selected => switch (this) {
    ConferencesLoaded(:final conference) => conference,
    _ => null,
  };

  /// Tracks available for the selected conference.
  List<EventItemType> get availableEventTypes =>
      tracksForConference(selected?.confId);
}

class ConferencesInitial extends ConferencesState {
  const ConferencesInitial();
}

class ConferencesLoaded extends ConferencesState {
  const ConferencesLoaded(this.conference);

  final Conference conference;
}

class ConferencesFailed extends ConferencesState {
  const ConferencesFailed();
}
