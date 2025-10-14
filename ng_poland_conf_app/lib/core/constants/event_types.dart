class EventContentTypes {
  static const String speaker = 'speaker';
  static const String workshop = 'workshop';
  static const String eventItem = 'eventItem';
  static const String simpleContent = 'simpleContent';
  static const String infoItem = 'infoItem';
  static const String version = 'version';
  static const String conferences = 'conferences';
}

enum EventItemType {
  ngPoland,
  jsPoland,
  aiPoland;

  String get imagePath {
    switch (this) {
      case EventItemType.aiPoland:
        return 'assets/images/aipolandlogo.png';
      case EventItemType.ngPoland:
        return 'assets/images/ngpolandlogo.png';
      case EventItemType.jsPoland:
        return 'assets/images/jspolandlogo.png';
    }
  }

  String get label {
    switch (this) {
      case EventItemType.aiPoland:
        return 'AI POLAND';
      case EventItemType.ngPoland:
        return 'NG POLAND';
      case EventItemType.jsPoland:
        return 'JS POLAND';
    }
  }
}

class SimpleContentId {
  static const String ngGirlsWorkshops = 'ng-girls-workshops';
}
