import 'package:ng_poland_conf_app/features/event/domains/usecases/get_rate_for_event.dart';
import 'package:ng_poland_conf_app/features/event/domains/usecases/rate_event.dart';

abstract class RateEventRepository {
  Future<int?> rateEvent(RateEventParams params);

  Future<int?> getRateForEvent(GetRateForEventParams params);
}
