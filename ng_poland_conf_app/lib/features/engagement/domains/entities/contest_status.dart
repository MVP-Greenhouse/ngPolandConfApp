enum ContestStatus { idle, open, drawing, finished }

extension ContestStatusX on ContestStatus {
  String get id => name;

  static ContestStatus fromId(String? raw) {
    return ContestStatus.values.firstWhere(
      (value) => value.name == raw,
      orElse: () => ContestStatus.idle,
    );
  }
}
