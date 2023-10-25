import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/info/datasources/data/info_local_datasource.dart';
import 'package:ng_poland_conf_app/features/info/datasources/data/info_remote_datasource.dart';
import 'package:ng_poland_conf_app/features/info/datasources/models/info_items_model.dart';
import 'package:ng_poland_conf_app/features/info/domains/entities/info_item.dart';
import 'package:ng_poland_conf_app/features/info/domains/repositories/info_repository.dart';
import 'package:ng_poland_conf_app/features/info/domains/usecases/get_all_info_items_for_conference.dart';

@Singleton(as: InfoRepository)
class InfoRepositoryImpl implements InfoRepository {
  final InfoRemoteDataSource infoRemoteDataSource;
  final InfoLocalDataSource infoLocalDataSource;

  InfoRepositoryImpl(
    this.infoRemoteDataSource,
    this.infoLocalDataSource,
  );

  @override
  Future<List<InfoItem>> getAllInfoItems(Params params) async {
    try {
      final InfoItemsModel infoItems = await infoRemoteDataSource.getAllInfoItems(
        confId: params.confId,
        limit: params.limit,
      );

      await infoLocalDataSource.update(infoItems);
      return infoItems.toEntity();
    } catch (err) {
      InfoItemsModel? infoItemsFromLocalDataSource = await infoLocalDataSource.get();
      return infoItemsFromLocalDataSource?.toEntity() ?? [];
    }
  }
}
