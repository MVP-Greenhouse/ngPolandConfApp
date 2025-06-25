import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/usecases/usecases.dart';
import 'package:ng_poland_conf_app/features/event/domains/entities/rate_event_basic_params.dart';
import 'package:ng_poland_conf_app/features/event/domains/repositories/rate_event_repository.dart';

@injectable
class RateEvent implements UseCase<int?, RateEventParams> {
  final RateEventRepository rateEventRepository;

  const RateEvent(this.rateEventRepository);

  @override
  Future<int?> call(RateEventParams params) async {
    return await rateEventRepository.rateEvent(params);
  }
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
