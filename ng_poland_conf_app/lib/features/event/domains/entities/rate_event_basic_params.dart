abstract class RateEventBasicParams {
  final String confId;
  final String eventId;
  final String eventItemType;

  String get keyForLocalStorage => confId + eventId;

  RateEventBasicParams({
    required this.confId,
    required this.eventId,
    required this.eventItemType,
  });
}
