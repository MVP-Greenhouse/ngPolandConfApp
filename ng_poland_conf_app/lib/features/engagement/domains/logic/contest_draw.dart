import 'dart:math';

class ContestDraw {
  const ContestDraw._();

  static List<String> pick({
    required List<String> participantIds,
    required Set<String> winnerIds,
    required int count,
    required Random random,
  }) {
    final pool = participantIds.where((id) => !winnerIds.contains(id)).toList();
    if (pool.isEmpty || count <= 0) return const [];
    pool.shuffle(random);
    final take = count > pool.length ? pool.length : count;
    return pool.take(take).toList();
  }
}
