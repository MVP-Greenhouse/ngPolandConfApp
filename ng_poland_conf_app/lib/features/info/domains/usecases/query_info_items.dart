import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecases.dart';
import '../entities/info_item.dart';
import '../repositories/info_repository.dart';

@injectable
class QueryInfoItems implements UseCase<List<InfoItem>, Params> {
  final InfoRepository infoRepository;

  QueryInfoItems(this.infoRepository);

  @override
  Future<List<InfoItem>> call(Params params) {
    return infoRepository.quryInfoItems(params);
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
