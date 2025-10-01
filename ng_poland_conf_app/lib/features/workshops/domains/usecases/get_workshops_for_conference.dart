import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/core/usecases/usecases.dart';
import 'package:ng_poland_conf_app/features/workshops/domains/entities/workshop.dart';
import 'package:ng_poland_conf_app/features/workshops/domains/repositories/workshops_repository.dart';

@injectable
class GetWorkshopsForConference implements UseCase<List<Workshop>?, Params> {
  final WorkshopsRepository workshopsRepository;

  GetWorkshopsForConference(this.workshopsRepository);

  @override
  Future<List<Workshop>> call(Params params) {
    return workshopsRepository.getWorkshops(params);
  }
}

class Params {
  final String eventItemType;
  final String confId;
  final int limit;

  String get customKey => EventContentTypes.workshop + eventItemType + confId;

  Params({
    required this.eventItemType,
    required this.confId,
    required this.limit,
  });
}
