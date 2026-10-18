import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:ng_poland_conf_app/core/domain/use_case.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/edition.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/speaker_profile.dart';
import 'package:ng_poland_conf_app/features/edition/domain/repositories/edition_repository.dart';
import 'package:ng_poland_conf_app/features/speakers/domain/entities/speaker_details.dart';
import 'package:ng_poland_conf_app/features/speakers/domain/exceptions/speaker_not_found_exception.dart';

@injectable
class GetSpeakerDetails
    implements UseCase<SpeakerDetails, GetSpeakerDetailsParams> {
  const GetSpeakerDetails(this._editions);

  static final _dateFormat = DateFormat('MMM d, y');

  final EditionRepository _editions;

  /// Throws [SpeakerNotFoundException] when the speaker is not in the agenda.
  @override
  Future<SpeakerDetails> call(GetSpeakerDetailsParams params) async {
    final edition = await _editions.load();
    final conference = params.conference;
    final profile =
        edition.speakerBySlug(params.slug, conference: conference) ??
        (throw const SpeakerNotFoundException());
    final workshops = uniqueSpeakerWorkshops(
      profile.workshops,
      conference: conference.isNotEmpty ? conference : profile.conference,
    );
    return SpeakerDetails(
      profile: profile,
      workshops: [
        for (final workshop in workshops) _resolve(workshop, edition),
      ],
      coSpeakers: [
        for (final slug in _coSpeakerSlugs(params))
          (
            slug: slug,
            name:
                edition.speakerBySlug(slug, conference: conference)?.name ??
                slug,
          ),
      ],
    );
  }

  SpeakerWorkshop _resolve(SpeakerWorkshopRef workshop, Edition edition) {
    final day = edition.days.firstWhereOrNull(
      (day) => day.workshopItems.any((item) => item.id == workshop.id),
    );
    final ownDate = DateTime.tryParse(workshop.date);
    return SpeakerWorkshop(
      workshop: workshop,
      dateLabel: switch ((ownDate, day?.dateLabel)) {
        (final date?, _) => _dateFormat.format(date),
        (null, final label?) when label.isNotEmpty => label,
        _ => null,
      },
      dayKey: day?.key,
    );
  }

  static List<String> _coSpeakerSlugs(GetSpeakerDetailsParams params) {
    final slugs = [
      for (final slug in params.workshopSpeakerSlugs)
        if (slug.isNotEmpty) slug,
    ];
    if (slugs.length < 2) return const [];
    return slugs.contains(params.initialSlug)
        ? slugs
        : [params.initialSlug, ...slugs];
  }
}

class GetSpeakerDetailsParams {
  const GetSpeakerDetailsParams({
    required this.slug,
    this.conference = '',
    this.workshopSpeakerSlugs = const [],
    String? initialSlug,
  }) : initialSlug = initialSlug ?? slug;

  /// Speaker to show.
  final String slug;
  final String conference;

  /// All speakers of the workshop the user came from (for switching).
  final List<String> workshopSpeakerSlugs;

  /// Speaker the page was opened for; kept first in the switcher.
  final String initialSlug;

  GetSpeakerDetailsParams withSlug(String slug) => GetSpeakerDetailsParams(
    slug: slug,
    conference: conference,
    workshopSpeakerSlugs: workshopSpeakerSlugs,
    initialSlug: initialSlug,
  );
}
