import 'package:ng_poland_conf_app/features/event/domains/entities/rate_event_basic_params.dart';

abstract class RateEventRepository {
  Future<int?> rateEvent(RateEventParams params);

  Future<int?> getRateForEvent(GetRateForEventParams params);
}
