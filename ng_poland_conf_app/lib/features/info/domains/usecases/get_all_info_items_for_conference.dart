import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/usecases/usecases.dart';
import 'package:ng_poland_conf_app/features/info/domains/entities/info_item.dart';
import 'package:ng_poland_conf_app/features/info/domains/repositories/info_repository.dart';

@injectable
class GetAllInfoItemsForConference implements UseCase<List<InfoItem>?, Params> {
  final InfoRepository infoRepository;

  GetAllInfoItemsForConference(this.infoRepository);

  @override
  Future<List<InfoItem>> call(Params params) {
    return infoRepository.getAllInfoItems(params);
  }
}

class Params {
  final String confId;
  final int limit;

  Params({
    required this.confId,
    required this.limit,
  });
}
