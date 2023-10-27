// ignore_for_file: file_names

import 'package:ng_poland_conf_app/features/nggirls/domains/entities/ngGirls.dart';
import 'package:ng_poland_conf_app/features/nggirls/domains/usecases/get_ngGirls_for_conference.dart';

abstract class NgGirlsRepository {
  Future<NgGirls?> getNgGirls(Params params);
}
