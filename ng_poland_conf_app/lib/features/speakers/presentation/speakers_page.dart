import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/cubit/speakers_cubit.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';

class SpeakersPage extends StatefulWidget {
  const SpeakersPage({super.key});

  @override
  State<SpeakersPage> createState() => _SpeakersPageState();
}

class _SpeakersPageState extends State<SpeakersPage> {
  late final SpeakersCubit _speakersCubit;

  @override
  void initState() {
    _speakersCubit = getIt.get<SpeakersCubit>();

    _speakersCubit.getListSpeakers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpeakersCubit, SpeakersState>(
      bloc: _speakersCubit,
      builder: (context, state) {
        return CustomScaffold(
          body: state.maybeWhen(
            loaded: (listSpeakers) => Column(
              children: [
                ...listSpeakers
                    .map(
                      (speaker) => Text(speaker.name ?? ''),
                    )
                    .toList(),
              ],
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
