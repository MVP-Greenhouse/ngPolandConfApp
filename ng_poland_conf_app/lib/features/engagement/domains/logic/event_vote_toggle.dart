class EventVoteToggle {
  const EventVoteToggle._();

  /// Returns whether the user should have an active like after toggle.
  static bool apply({required bool currentlyLiked}) => !currentlyLiked;
}

int nextOptimisticLikes({
  required bool liked,
  required bool wasLiked,
  required int currentLikes,
}) {
  if (liked && !wasLiked) return currentLikes + 1;
  if (!liked && wasLiked) return currentLikes > 0 ? currentLikes - 1 : 0;
  return currentLikes;
}
