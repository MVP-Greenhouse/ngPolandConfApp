part of 'admin_cubit.dart';

@freezed
abstract class AdminState with _$AdminState {
  const AdminState._();

  const factory AdminState({
    @Default(false) bool isAdmin,
    String? latestConfId,
    EngagementConfig? config,
    @Default(<SpeakerVoteRank>[]) List<SpeakerVoteRank> ranking,
    @Default(<ContestParticipant>[]) List<ContestParticipant> participants,
    @Default(<ContestWinner>[]) List<ContestWinner> winners,
    String? message,
    @Default(false) bool loading,
  }) = _AdminState;
}
