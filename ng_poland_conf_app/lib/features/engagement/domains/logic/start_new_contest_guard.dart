import '../entities/contest_status.dart';

class StartNewContestGuard {
  const StartNewContestGuard._();
  static String? validate({
    required ContestStatus status,
    required String name,
  }) {
    if (status != ContestStatus.finished) {
      return 'Konkurs musi być zakończony';
    }
    if (name.trim().isEmpty) return 'Podaj nazwę konkursu';
    return null;
  }
}
