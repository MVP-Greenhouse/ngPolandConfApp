part of 'speakers_cubit.dart';

sealed class SpeakersState {
  const SpeakersState(this.track);

  final EventItemType track;
}

class SpeakersLoading extends SpeakersState {
  const SpeakersLoading(super.track);
}

class SpeakersLoaded extends SpeakersState {
  const SpeakersLoaded(super.track, this.speakers);

  final List<SpeakerListItem> speakers;
}

class SpeakersFailed extends SpeakersState {
  const SpeakersFailed(super.track);
}
