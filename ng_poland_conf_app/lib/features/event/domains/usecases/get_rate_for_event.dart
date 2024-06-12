import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/usecases/usecases.dart';
import 'package:ng_poland_conf_app/features/event/domains/entities/rate_event_basic_params.dart';
import 'package:ng_poland_conf_app/features/event/domains/repositories/rate_event_repository.dart';

@injectable
class GetRateForEvent implements UseCase<int?, GetRateForEventParams> {
  final RateEventRepository rateEventRepository;

  const GetRateForEvent(this.rateEventRepository);

  @override
  Future<int?> call(GetRateForEventParams params) async {
    return await rateEventRepository.getRateForEvent(params);
  }
}

class GetRateForEventParams extends RateEventBasicParams {
  GetRateForEventParams({
    required super.confId,
    required super.eventId,
    required super.eventItemType,
  });
}
