import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecases.dart';
import '../entities/info_item.dart';
import '../repositories/info_repository.dart';

@injectable
class SaveInfoItems implements UseCase<void, SaveInfoItemsParams> {
  final InfoRepository infoRepository;

  SaveInfoItems(this.infoRepository);

  @override
  Future<void> call(SaveInfoItemsParams params) {
    return infoRepository.saveInfoItems(params.infoItems);
  }
}

class SaveInfoItemsParams {
  final List<InfoItem> infoItems;

  SaveInfoItemsParams({
    required this.infoItems,
  });
}
