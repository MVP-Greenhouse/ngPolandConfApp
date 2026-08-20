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
}
