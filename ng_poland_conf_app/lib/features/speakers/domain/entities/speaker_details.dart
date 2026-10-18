import 'package:ng_poland_conf_app/features/edition/domain/entities/speaker_profile.dart';

/// A workshop of a speaker with its agenda placement resolved.
class SpeakerWorkshop {
  const SpeakerWorkshop({
    required this.workshop,
    required this.dateLabel,
    required this.dayKey,
  });

  final SpeakerWorkshopRef workshop;
  final String? dateLabel;

  /// Agenda day that lists the workshop, used to open it on the workshops tab.
  final String? dayKey;
}

/// Another speaker of the same workshop the user can switch to.
typedef CoSpeaker = ({String slug, String name});

class SpeakerDetails {
  const SpeakerDetails({
    required this.profile,
    required this.workshops,
    required this.coSpeakers,
  });

  final SpeakerProfile profile;
  final List<SpeakerWorkshop> workshops;

  /// Empty unless the speaker shares a workshop with others.
  final List<CoSpeaker> coSpeakers;
}
