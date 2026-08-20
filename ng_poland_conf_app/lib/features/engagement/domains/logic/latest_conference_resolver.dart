class LatestConferenceResolver {
  const LatestConferenceResolver._();

  static String? fromConfIds(Iterable<String> ids) {
    final parsed = <({String id, int year})>[];
    for (final id in ids) {
      final year = int.tryParse(id);
      if (year != null) {
        parsed.add((id: id, year: year));
      }
    }
    if (parsed.isEmpty) return null;
    parsed.sort((a, b) => b.year.compareTo(a.year));
    return parsed.first.id;
  }
}
