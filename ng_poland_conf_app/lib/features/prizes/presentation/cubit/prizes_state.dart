part of 'prizes_cubit.dart';

@freezed
abstract class PrizesState with _$PrizesState {
  const factory PrizesState({
    @Default(false) bool hasPrizes,
    @Default(<UserPrize>[]) List<UserPrize> prizes,
    @Default(true) bool loading,
  }) = _PrizesState;
}
