import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/usecases/usecases.dart';

import '../entities/ngGirls.dart';
import '../repositories/ngGirls_repository.dart';

@injectable
class QueryNgGirls implements UseCase<NgGirls?, NgGirlsQueryParams> {
  final NgGirlsRepository ngGirlsRepository;

  QueryNgGirls(this.ngGirlsRepository);

  @override
  Future<NgGirls?> call(NgGirlsQueryParams params) {
    return ngGirlsRepository.queryNgGirls(params);
  }
}

class NgGirlsQueryParams {
  final String confId;
  final int limit;

  NgGirlsQueryParams({
    required this.confId,
    required this.limit,
  });
}
