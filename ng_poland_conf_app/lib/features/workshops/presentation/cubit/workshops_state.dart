part of 'workshops_cubit.dart';

sealed class WorkshopsState {
  const WorkshopsState();
}

class WorkshopsLoading extends WorkshopsState {
  const WorkshopsLoading();
}

class WorkshopsFailed extends WorkshopsState {
  const WorkshopsFailed();
}

class WorkshopsLoaded extends WorkshopsState {
  const WorkshopsLoaded({
    required this.days,
    required this.selected,
    this.pendingScrollId,
  });

  final List<WorkshopDay> days;
  final WorkshopDay? selected;

  /// Workshop the list should scroll to once it is laid out.
  final int? pendingScrollId;
}
