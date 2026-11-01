bool editionCacheIsFresh({
  required DateTime fetchedAt,
  required DateTime now,
  Duration maxAge = const Duration(minutes: 5),
}) {
  return now.difference(fetchedAt) < maxAge;
}
