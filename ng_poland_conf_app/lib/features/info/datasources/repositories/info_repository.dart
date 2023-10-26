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
    final currentInfoItemsModel = await infoLocalDataSource.get();
    try {
      if (currentInfoItemsModel != null &&
          currentInfoItemsModel.items != null &&
          currentInfoItemsModel.items!.isNotEmpty &&
          currentInfoItemsModel.lastUpdate != null &&
          currentInfoItemsModel.confId != null &&
          currentInfoItemsModel.confId == params.confId &&
          currentInfoItemsModel.lastUpdate!.isAfter(DateTime.now().subtract(const Duration(minutes: 5)))) {
        return currentInfoItemsModel.toEntity();
      }

      final InfoItemsModel infoItems = await infoRemoteDataSource.getAllInfoItems(
        confId: params.confId,
        limit: params.limit,
      );

      await infoLocalDataSource.update(infoItems.copyWith(confId: params.confId, lastUpdate: DateTime.now()));
      return infoItems.toEntity();
    } catch (err) {
      if (currentInfoItemsModel != null && currentInfoItemsModel.confId == params.confId) {
        return currentInfoItemsModel.toEntity();
      } else {
        return [];
      }
    }
  }
}
