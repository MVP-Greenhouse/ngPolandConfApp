import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/usecases/usecases.dart';
import 'package:ng_poland_conf_app/features/nggirls/domains/entities/ngGirls.dart';
import 'package:ng_poland_conf_app/features/nggirls/domains/repositories/ngGirls_repository.dart';

@injectable
class GetNgGirlsForConference implements UseCase<NgGirls?, Params> {
  final NgGirlsRepository ngGirlsRepository;

  GetNgGirlsForConference(this.ngGirlsRepository);

  @override
  Future<NgGirls?> call(Params params) {
    return ngGirlsRepository.getNgGirls(params);
  }
}

class Params {
  final String confId;

  Params({
    required this.confId,
  });
}
