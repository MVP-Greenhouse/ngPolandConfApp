import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/info/datasources/data/info_remote_datasource.dart';
import 'package:ng_poland_conf_app/features/info/domains/entities/info_item.dart';
import 'package:ng_poland_conf_app/features/info/domains/repositories/info_repository.dart';

import '../../domains/usecases/query_info_items.dart';
import '../data/info_local_datasource.dart';

@Singleton(as: InfoRepository)
class InfoRepositoryImpl implements InfoRepository {
  final InfoRemoteDataSource infoRemoteDataSource;
  final InfoLocalDataSource infoLocalDataSource;

  InfoRepositoryImpl(this.infoRemoteDataSource, this.infoLocalDataSource);

  @override
  Future<List<InfoItem>> getAllInfoItems() async {
    final infoItems = await infoLocalDataSource.getAllInfoItems();

    return infoItems;
  }

  @override
  Future<List<InfoItem>> quryInfoItems(Params params) async {
    final infoItems = await infoRemoteDataSource.queryInfoItems(
      confId: params.confId,
      limit: params.limit,
    );

    return infoItems.toEntity();
  }

  @override
  Future<void> saveInfoItems(List<InfoItem> items) {
    return infoLocalDataSource.saveInfoItems(items);
  }
}
