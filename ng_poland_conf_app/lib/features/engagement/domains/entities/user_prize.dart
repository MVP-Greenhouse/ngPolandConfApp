class UserPrize {
  const UserPrize({
    required this.contestId,
    required this.contestName,
    required this.order,
    this.finishedAt,
  });
  final String contestId;
  final String contestName;
  final int order;
  final DateTime? finishedAt;
}
