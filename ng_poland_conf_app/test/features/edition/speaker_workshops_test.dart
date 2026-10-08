import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/edition/domains/entities/edition.dart';
import 'package:ng_poland_conf_app/features/edition/domains/entities/speaker_profile.dart';

void main() {
  test('keeps the workshop session that matches the speaker conference', () {
    const title = 'Agentic UI';
    final selected = uniqueSpeakerWorkshops(const [
      SpeakerWorkshopRef(id: 115, title: title, url: '', conference: 'ai'),
      SpeakerWorkshopRef(id: 114, title: title, url: '', conference: 'js'),
      SpeakerWorkshopRef(id: 113, title: title, url: '', conference: 'ng'),
      SpeakerWorkshopRef(
        id: 92,
        title: 'Modern Angular',
        url: '',
        conference: 'ng',
      ),
    ], conference: 'ng');

    expect(selected.map((workshop) => workshop.id), [113, 92]);
  });

  test('speakerBySlug returns the profile for the requested conference', () {
    final edition = Edition(
      year: 2026,
      venue: null,
      ticketsUrl: '',
      days: const [],
      speakers: [
        _profile(slug: 'manfred-steyer', conference: 'ng'),
        _profile(slug: 'manfred-steyer', conference: 'js'),
      ],
    );

    expect(
      edition.speakerBySlug('manfred-steyer', conference: 'js')?.conference,
      'js',
    );
    expect(edition.speakerBySlug('manfred-steyer')?.conference, 'ng');
  });
}

SpeakerProfile _profile({required String slug, required String conference}) {
  return SpeakerProfile(
    id: 0,
    slug: slug,
    name: 'Manfred Steyer',
    conference: conference,
    conferenceLabel: conference,
    color: '',
    position: '',
    company: '',
    country: '',
    photo: '',
    bioHtml: '',
    bio: '',
    talk: null,
    socials: const [],
    books: const [],
    videos: const [],
    workshops: const [],
    agendaItems: const [],
  );
}
