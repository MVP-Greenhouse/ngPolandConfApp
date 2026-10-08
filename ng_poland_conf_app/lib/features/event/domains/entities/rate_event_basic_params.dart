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

class GetRateForEventParams extends RateEventBasicParams {
  GetRateForEventParams({
    required super.confId,
    required super.eventId,
    required super.eventItemType,
  });
}

class RateEventParams extends RateEventBasicParams {
  final int rate;

  RateEventParams({
    required super.confId,
    required super.eventId,
    required super.eventItemType,
    required this.rate,
  });
}
