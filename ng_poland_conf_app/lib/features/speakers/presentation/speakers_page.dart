import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/cubit/speakers_cubit.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';

import '../../../widgets/empty_list_info.dart';
import 'widgets/speaker_tile.dart';

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
          appBar: AppBar(
            title: Text(
              'Speakers',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.inversePrimary),
            ),
          ),
          body: state.maybeWhen(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (listSpeakers) => listSpeakers.isEmpty
                ? const EmptyListInformation()
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: ListView.builder(
                      itemCount: listSpeakers.length,
                      itemBuilder: (context, index) {
                        return SpeakerTile(listSpeakers[index]);
                      },
                    ),
                  ),
            orElse: () => const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
