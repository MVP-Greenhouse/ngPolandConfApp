import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/nggirls/datasources/data/ngGirls_local_datasource.dart';
import 'package:ng_poland_conf_app/features/nggirls/datasources/data/ngGirls_remote_datasource.dart';
import 'package:ng_poland_conf_app/features/nggirls/domains/entities/ngGirls.dart';
import 'package:ng_poland_conf_app/features/nggirls/domains/repositories/ngGirls_repository.dart';
import 'package:ng_poland_conf_app/features/nggirls/domains/usecases/get_ngGirls_for_conference.dart';
import 'package:ng_poland_conf_app/features/nggirls/domains/usecases/query_ngGirls.dart';

@Singleton(as: NgGirlsRepository)
class NgGirlsImpl implements NgGirlsRepository {
  final NgGirlsRemoteDataSource ngGirlsRemoteDataSource;
  final NgGirlsLocalDataSource ngGirlsLocalDataSource;

  NgGirlsImpl(this.ngGirlsRemoteDataSource, this.ngGirlsLocalDataSource);

  @override
  Future<NgGirls> getNgGirls(Params params) async {
    final workshops = await ngGirlsLocalDataSource.getNgGirls();

    return workshops;
  }

  @override
  Future<NgGirls> queryNgGirls(NgGirlsQueryParams params) async {
    final ngGirls = await ngGirlsRemoteDataSource.queryNgGirls(ngGirlsWorkshopsId: SimpleContentId.ngGirlsWorkshops, confId: params.confId);

    return ngGirls.toEntity();
  }

  @override
  Future<void> saveNgGirls(NgGirls ngGirls) {
    return ngGirlsLocalDataSource.saveNgGirls(ngGirls);
  }
}
