import 'contest_status.dart';

class EngagementConfig {
  const EngagementConfig({
    required this.votingEnabled,
    required this.votingStartsAt,
    required this.votingEndsAt,
    required this.contestEnabled,
    required this.contestStartsAt,
    required this.contestEndsAt,
    required this.contestStatus,
    this.contestName = '',
    this.contestId = '',
  });

  final bool votingEnabled;
  final DateTime votingStartsAt;
  final DateTime votingEndsAt;
  final bool contestEnabled;
  final DateTime contestStartsAt;
  final DateTime contestEndsAt;
  final ContestStatus contestStatus;
  final String contestName;
  final String contestId;

  static final missing = EngagementConfig(
    votingEnabled: false,
    votingStartsAt: DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
    votingEndsAt: DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
    contestEnabled: false,
    contestStartsAt: DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
    contestEndsAt: DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
    contestStatus: ContestStatus.idle,
  );

  bool isVotingOpen(DateTime now) {
    return votingEnabled && _inWindow(now, votingStartsAt, votingEndsAt);
  }

  bool isContestJoinOpen(DateTime now) {
    final statusAllowsJoin =
        contestStatus == ContestStatus.idle || contestStatus == ContestStatus.open;
    return contestEnabled &&
        statusAllowsJoin &&
        _inWindow(now, contestStartsAt, contestEndsAt);
  }

  EngagementConfig copyWith({
    bool? votingEnabled,
    DateTime? votingStartsAt,
    DateTime? votingEndsAt,
    bool? contestEnabled,
    DateTime? contestStartsAt,
    DateTime? contestEndsAt,
    ContestStatus? contestStatus,
    String? contestName,
    String? contestId,
  }) {
    return EngagementConfig(
      votingEnabled: votingEnabled ?? this.votingEnabled,
      votingStartsAt: votingStartsAt ?? this.votingStartsAt,
      votingEndsAt: votingEndsAt ?? this.votingEndsAt,
      contestEnabled: contestEnabled ?? this.contestEnabled,
      contestStartsAt: contestStartsAt ?? this.contestStartsAt,
      contestEndsAt: contestEndsAt ?? this.contestEndsAt,
      contestStatus: contestStatus ?? this.contestStatus,
      contestName: contestName ?? this.contestName,
      contestId: contestId ?? this.contestId,
    );
  }

  static bool _inWindow(DateTime now, DateTime start, DateTime end) {
    return !now.isBefore(start) && !now.isAfter(end);
  }
}
