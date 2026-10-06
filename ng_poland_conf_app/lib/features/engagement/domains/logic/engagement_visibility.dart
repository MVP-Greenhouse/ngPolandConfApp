class EngagementVisibility {
  const EngagementVisibility._();

  static bool showVoting({
    required String? selectedConfId,
    required String? latestConfId,
    required bool votingOpen,
  }) {
    if (selectedConfId == null || latestConfId == null) return false;
    return selectedConfId == latestConfId && votingOpen;
  }

  static bool showTop5({
    required String? selectedConfId,
    required String? latestConfId,
    required bool top5Enabled,
  }) {
    if (selectedConfId == null || latestConfId == null) return false;
    return selectedConfId == latestConfId && top5Enabled;
  }
}
