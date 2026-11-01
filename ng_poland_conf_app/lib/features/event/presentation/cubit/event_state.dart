part of 'event_cubit.dart';

sealed class EventState {
  const EventState();
}

class EventLoading extends EventState {
  const EventLoading();
}

class EventLoaded extends EventState {
  const EventLoaded({required this.event, required this.hasDescription});

  final EventItem event;

  /// Precomputed so the page does not parse HTML while building.
  final bool hasDescription;
}

class EventFailed extends EventState {
  const EventFailed(this.message);

  final String message;
}
