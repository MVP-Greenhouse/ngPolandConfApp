part of 'speaker_details_cubit.dart';

sealed class SpeakerDetailsState {
  const SpeakerDetailsState();
}

class SpeakerDetailsLoading extends SpeakerDetailsState {
  const SpeakerDetailsLoading();
}

class SpeakerDetailsLoaded extends SpeakerDetailsState {
  const SpeakerDetailsLoaded(this.details, {required this.conference});

  final SpeakerDetails details;
  final String conference;
}

class SpeakerDetailsFailed extends SpeakerDetailsState {
  const SpeakerDetailsFailed();
}
