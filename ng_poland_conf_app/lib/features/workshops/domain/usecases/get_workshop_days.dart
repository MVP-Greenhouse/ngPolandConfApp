import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/domain/use_case.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/agenda.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/edition.dart';
import 'package:ng_poland_conf_app/features/edition/domain/repositories/edition_repository.dart';
import 'package:ng_poland_conf_app/features/workshops/domain/entities/workshop_day.dart';
import 'package:ng_poland_conf_app/features/workshops/domain/services/workshop_labels.dart';

@injectable
class GetWorkshopDays implements NoParamsUseCase<List<WorkshopDay>> {
  const GetWorkshopDays(this._editions);

  final EditionRepository _editions;

  @override
  Future<List<WorkshopDay>> call() async {
    final edition = await _editions.load();
    return [
      for (final day in edition.days)
        if (day.kind == .workshops) _day(day, edition),
    ];
  }

  static WorkshopDay _day(AgendaDay day, Edition edition) {
    final date = workshopDateParts(day.dateLabel);
    return WorkshopDay(
      key: day.key,
      tabLabel: workshopTabLabel(day.homeName),
      month: date.month,
      dayOfMonth: date.day,
      workshops: [
        for (final workshop in day.workshopItems) _item(workshop, edition),
      ],
    );
  }

  static WorkshopListItem _item(WorkshopAgendaItem workshop, Edition edition) {
    return WorkshopListItem(
      workshop: workshop,
      conferenceLabel: [
        workshop.conferenceLabel.toUpperCase(),
        if (edition.year > 0) '${edition.year}',
      ].join(' '),
      priceLabel: workshopPriceLabel(
        pricePln: workshop.pricePln,
        priceEur: workshop.priceEur,
      ),
      speakers: [
        for (final speaker in workshop.speakers)
          (speaker: speaker, role: _role(speaker, workshop, edition)),
      ],
    );
  }

  static String _role(
    SpeakerSummary speaker,
    WorkshopAgendaItem workshop,
    Edition edition,
  ) {
    if (speaker.roleLabel.isNotEmpty) return speaker.roleLabel;
    if (speaker.slug.isEmpty) return '';
    return edition
            .speakerBySlug(speaker.slug, conference: workshop.conference)
            ?.roleLabel ??
        '';
  }
}
