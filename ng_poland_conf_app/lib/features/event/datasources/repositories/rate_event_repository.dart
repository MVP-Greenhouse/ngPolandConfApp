import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/event/datasources/data/local/rate_event_local_datasource.dart';
import 'package:ng_poland_conf_app/features/event/datasources/data/remote/rate_event_remote_datasource.dart';
import 'package:ng_poland_conf_app/features/event/domains/repositories/rate_event_repository.dart';
import 'package:ng_poland_conf_app/features/event/domains/usecases/get_rate_for_event.dart';
import 'package:ng_poland_conf_app/features/event/domains/usecases/rate_event.dart';

@Singleton(as: RateEventRepository)
class RateEventRepositoryImpl implements RateEventRepository {
  final RateEventRemoteDataSource rateEventRemoteDataSource;
  final RateEventLocalDataSource rateEventLocalDataSource;

  RateEventRepositoryImpl(this.rateEventRemoteDataSource, this.rateEventLocalDataSource);

  @override
  Future<int?> rateEvent(RateEventParams params) async {
    try {
      final int rateForEvent = await rateEventRemoteDataSource.rateEvent(
        confId: params.confId,
        eventId: params.eventId,
        eventItemType: params.eventItemType,
        rate: params.rate,
      );
      await rateEventLocalDataSource.update(
        rateForEvent,
        customKey: params.keyForLocalStorage,
      );
      return rateForEvent;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<int?> getRateForEvent(GetRateForEventParams params) async {
    try {
      final int rateForEvent = await rateEventRemoteDataSource.getRateForEvent(
        confId: params.confId,
        eventId: params.eventId,
        eventItemType: params.eventItemType,
      );
      await rateEventLocalDataSource.update(
        rateForEvent,
        customKey: params.keyForLocalStorage,
      );
      return rateForEvent;
    } catch (_) {
      final int? rateForEvent = await rateEventLocalDataSource.get(
        customKey: params.keyForLocalStorage,
      );
      return rateForEvent;
    }
  }
}
