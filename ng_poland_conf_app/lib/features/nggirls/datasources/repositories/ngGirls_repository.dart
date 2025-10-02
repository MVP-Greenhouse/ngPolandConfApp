// ignore_for_file: file_names

import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/nggirls/datasources/data/ngGirls_local_datasource.dart';
import 'package:ng_poland_conf_app/features/nggirls/datasources/data/ngGirls_remote_datasource.dart';
import 'package:ng_poland_conf_app/features/nggirls/datasources/models/ngGirls_model.dart';
import 'package:ng_poland_conf_app/features/nggirls/domains/entities/ngGirls.dart';
import 'package:ng_poland_conf_app/features/nggirls/domains/repositories/ngGirls_repository.dart';
import 'package:ng_poland_conf_app/features/nggirls/domains/usecases/get_ngGirls_for_conference.dart';

@Singleton(as: NgGirlsRepository)
class NgGirlsImpl implements NgGirlsRepository {
  final NgGirlsRemoteDataSource ngGirlsRemoteDataSource;
  final NgGirlsLocalDataSource ngGirlsLocalDataSource;

  NgGirlsImpl(
    this.ngGirlsRemoteDataSource,
    this.ngGirlsLocalDataSource,
  );

  @override
  Future<NgGirls?> getNgGirls(Params params) async {
    final NgGirlsModel? currentNgGirlsModel = await ngGirlsLocalDataSource.get(
      customKey: params.confId,
    );
    try {
      if (currentNgGirlsModel != null &&
          currentNgGirlsModel.myId == SimpleContentId.ngGirlsWorkshops &&
          currentNgGirlsModel.confId == params.confId &&
          currentNgGirlsModel.lastUpdate != null &&
          currentNgGirlsModel.lastUpdate!.isAfter(DateTime.now().subtract(const Duration(minutes: 5)))) {
        return currentNgGirlsModel.toEntity();
      }

      final NgGirlsModel workshops = await ngGirlsRemoteDataSource.getNgGirls(
        ngGirlsWorkshopsId: SimpleContentId.ngGirlsWorkshops,
        confId: params.confId,
      );

      await ngGirlsLocalDataSource.update(
        workshops.copyWith(lastUpdate: DateTime.now(), confId: params.confId),
        customKey: params.customKey,
      );
      return workshops.toEntity();
    } catch (err) {
      if (currentNgGirlsModel != null && currentNgGirlsModel.confId == params.confId) {
        return currentNgGirlsModel.toEntity();
      } else {
        return null;
      }
    }
  }
}
