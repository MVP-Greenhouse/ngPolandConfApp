import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/nggirls/datasources/data/ngGirls_remote_datasource.dart';
import 'package:ng_poland_conf_app/features/nggirls/domains/entities/ngGirls.dart';
import 'package:ng_poland_conf_app/features/nggirls/domains/repositories/ngGirls_repository.dart';
import 'package:ng_poland_conf_app/features/nggirls/domains/usecases/get_ngGirls_for_conference.dart';

@Singleton(as: NgGirlsRepository)
class NgGirlsImpl implements NgGirlsRepository {
  final NgGirlsRemoteDataSource ngGirlsRemoteDataSource;

  NgGirlsImpl(this.ngGirlsRemoteDataSource);

  @override
  Future<NgGirls> getNgGirls(Params params) async {
    final workshops = await ngGirlsRemoteDataSource.getNgGirls(
      ngGirlsWorkshopsId: SimpleContentId.ngGirlsWorkshops,
      confId: params.confId,
    );

    return workshops.toEntity();
  }
}
