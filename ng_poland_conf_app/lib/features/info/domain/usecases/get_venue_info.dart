import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/domain/use_case.dart';
import 'package:ng_poland_conf_app/core/utils/object_extensions.dart';
import 'package:ng_poland_conf_app/features/edition/domain/repositories/edition_repository.dart';
import 'package:ng_poland_conf_app/features/info/domain/entities/venue_info.dart';
import 'package:ng_poland_conf_app/features/info/domain/services/venue_labels.dart';

@injectable
class GetVenueInfo implements NoParamsUseCase<VenueInfo> {
  const GetVenueInfo(this._editions);

  final EditionRepository _editions;

  @override
  Future<VenueInfo> call() async {
    final edition = await _editions.load();
    return VenueInfo(
      venue: edition.venue,
      city: edition.venue?.address.let(venueCityLabel),
      ticketsUrl: edition.ticketsUrl,
      days: edition.days,
      daysLabel: agendaDaysLabel(edition.days),
    );
  }
}
