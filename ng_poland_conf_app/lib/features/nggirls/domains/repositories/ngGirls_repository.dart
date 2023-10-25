import 'package:ng_poland_conf_app/features/nggirls/domains/entities/ngGirls.dart';
import 'package:ng_poland_conf_app/features/nggirls/domains/usecases/get_ngGirls_for_conference.dart';
import 'package:ng_poland_conf_app/features/nggirls/domains/usecases/query_ngGirls.dart';

abstract class NgGirlsRepository {
  Future<NgGirls> getNgGirls(Params params);
  Future<NgGirls> queryNgGirls(NgGirlsQueryParams params);
  Future<void> saveNgGirls(NgGirls ngGirls);
}
