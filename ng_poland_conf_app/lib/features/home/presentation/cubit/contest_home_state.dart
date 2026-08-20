part of 'contest_home_cubit.dart';

@freezed
abstract class ContestHomeState with _$ContestHomeState {
  const ContestHomeState._();

  const factory ContestHomeState({
    @Default(ContestHomeView.hidden) ContestHomeView view,
    String? latestConfId,
    UserProfile? profile,
    @Default(false) bool joinFailed,
  }) = _ContestHomeState;
}
