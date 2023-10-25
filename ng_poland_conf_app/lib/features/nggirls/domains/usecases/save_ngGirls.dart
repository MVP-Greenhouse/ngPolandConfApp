import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/usecases/usecases.dart';

import '../entities/ngGirls.dart';
import '../repositories/ngGirls_repository.dart';

@injectable
class SaveNgGirls implements UseCase<void, SaveNgGirlsParams> {
  final NgGirlsRepository ngGirlsRepository;

  SaveNgGirls(this.ngGirlsRepository);

  @override
  Future<void> call(SaveNgGirlsParams params) {
    return ngGirlsRepository.saveNgGirls(params.ngGirls);
  }
}

class SaveNgGirlsParams {
  final NgGirls ngGirls;

  SaveNgGirlsParams({
    required this.ngGirls,
  });
}
