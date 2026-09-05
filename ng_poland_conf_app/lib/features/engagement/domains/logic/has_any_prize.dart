class HasAnyPrize {
  const HasAnyPrize._();
  static bool resolve({
    required int historyWins,
    required bool hasActiveWin,
  }) =>
      historyWins > 0 || hasActiveWin;
}
