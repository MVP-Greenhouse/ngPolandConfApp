import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/speaker_profile.dart';
import 'package:ng_poland_conf_app/features/speakers/domain/entities/speaker_details.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/cubit/speaker_details_cubit.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/pages/speaker_details_page.dart';

import '../../../../helpers/page_on_phone.dart';

class _FakeSpeakerDetailsCubit extends Cubit<SpeakerDetailsState>
    implements SpeakerDetailsCubit {
  _FakeSpeakerDetailsCubit()
    : super(
        const SpeakerDetailsLoaded(
          SpeakerDetails(
            profile: SpeakerProfile(
              id: 0,
              slug: 'ada',
              name: 'Ada Example',
              conference: 'ngPoland',
              conferenceLabel: 'NG Poland',
              color: '',
              position: '',
              company: '',
              country: '',
              photo: '',
              bioHtml: '',
              bio: 'Builds things.',
              talk: null,
              socials: [],
              books: [],
              videos: [],
              workshops: [],
              agendaItems: [],
            ),
            workshops: [],
            coSpeakers: [],
          ),
          conference: 'ngPoland',
        ),
      );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  testWidgets('the list leaves room for the navigation bar', (tester) async {
    await pumpPageOnPhone(
      tester,
      BlocProvider<SpeakerDetailsCubit>(
        create: (_) => _FakeSpeakerDetailsCubit(),
        child: const SpeakerDetailsPage(),
      ),
    );

    expect(listBottomPadding(tester), greaterThan(navigationBarHeight));
  });
}
