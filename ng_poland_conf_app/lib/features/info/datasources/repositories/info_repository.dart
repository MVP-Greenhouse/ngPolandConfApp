import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/info/datasources/data/info_remote_datasource.dart';
import 'package:ng_poland_conf_app/features/info/domains/entities/info_item.dart';
import 'package:ng_poland_conf_app/features/info/domains/repositories/info_repository.dart';
import 'package:ng_poland_conf_app/features/info/domains/usecases/get_all_info_items_for_conference.dart';

@Singleton(as: InfoRepository)
class InfoRepositoryImpl implements InfoRepository {
  final InfoRemoteDataSource infoRemoteDataSource;

  InfoRepositoryImpl(this.infoRemoteDataSource);

  @override
  Future<List<InfoItem>> getAllInfoItems(Params params) async {
    final infoItems = await infoRemoteDataSource.getAllInfoItems(
      confId: params.confId,
      limit: params.limit,
    );

    return infoItems.toEntity();
  }
}
