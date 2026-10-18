part of 'schedule_top5_cubit.dart';

sealed class ScheduleTop5State {
  const ScheduleTop5State();

  bool get isVotingOpen => switch (this) {
    Top5Ready(:final board) => board.votingOpen,
    _ => false,
  };
}

class Top5StateHidden extends ScheduleTop5State {
  const Top5StateHidden();
}

class Top5StateLoading extends ScheduleTop5State {
  const Top5StateLoading();
}

/// Board loaded; [board.top] may be empty when nobody voted yet.
class Top5Ready extends ScheduleTop5State {
  const Top5Ready(this.board);

  final Top5Board board;
}
