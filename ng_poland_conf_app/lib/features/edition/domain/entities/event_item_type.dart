/// A conference track of the edition (one agenda day per track).
enum EventItemType {
  ngPoland(conferenceKey: 'ng', label: 'NG POLAND'),
  jsPoland(conferenceKey: 'js', label: 'JS POLAND'),
  aiPoland(conferenceKey: 'ai', label: 'AI POLAND');

  const EventItemType({required this.conferenceKey, required this.label});

  /// Key used by the ng-poland API for the track's agenda day and speakers.
  final String conferenceKey;
  final String label;

  String get imagePath => switch (this) {
    .ngPoland => 'assets/images/ngpolandlogo.png',
    .jsPoland => 'assets/images/jspolandlogo.png',
    .aiPoland => 'assets/images/aipolandlogo.png',
  };

  static final _byName = values.asNameMap();

  /// Parses [EventItemType.name] (as used in routes and Firestore documents).
  static EventItemType? fromName(String? name) => _byName[name];

  /// Parses [conferenceKey] (`ng`, `js`, `ai`).
  static EventItemType? fromConferenceKey(String? key) =>
      values.where((type) => type.conferenceKey == key).firstOrNull;
}
