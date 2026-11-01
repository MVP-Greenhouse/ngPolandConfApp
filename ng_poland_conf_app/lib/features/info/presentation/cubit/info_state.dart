part of 'info_cubit.dart';

sealed class InfoState {
  const InfoState();
}

class InfoLoading extends InfoState {
  const InfoLoading();
}

class InfoLoaded extends InfoState {
  const InfoLoaded(this.info);

  final VenueInfo info;
}

class InfoFailed extends InfoState {
  const InfoFailed();
}
