import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/domain/use_case.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/edition.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/speaker.dart';
import 'package:ng_poland_conf_app/features/edition/domain/repositories/edition_repository.dart';
import 'package:ng_poland_conf_app/features/edition/domain/services/edition_projections.dart';
import 'package:ng_poland_conf_app/features/speakers/domain/entities/speaker_list_item.dart';
import 'package:ng_poland_conf_app/features/speakers/domain/services/speaker_sessions.dart';

@injectable
class GetTrackSpeakers
    implements UseCase<List<SpeakerListItem>, EventItemType> {
  const GetTrackSpeakers(this._editions);

  final EditionRepository _editions;

  @override
  Future<List<SpeakerListItem>> call(EventItemType track) async {
    final edition = await _editions.load();
    return [
      for (final speaker in speakersFromEdition(edition))
        if (speaker.conferenceKey == track.conferenceKey)
          _item(speaker, edition),
    ];
  }

  static SpeakerListItem _item(Speaker speaker, Edition edition) {
    final profile = edition.speakerBySlug(
      speaker.id ?? '',
      conference: speaker.conferenceKey,
    );
    return SpeakerListItem(
      speaker: speaker,
      position: profile?.position ?? '',
      company: profile?.company ?? '',
      color: profile?.color ?? '',
      sessions: speakerSessions(speaker.talkTitle),
    );
  }
}
