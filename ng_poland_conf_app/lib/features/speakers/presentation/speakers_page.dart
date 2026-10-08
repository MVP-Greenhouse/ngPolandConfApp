import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/core/mixins/connectivity_mixin.dart';
import 'package:ng_poland_conf_app/features/edition/domains/logic/edition_projections.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/cubit/speakers_cubit.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/theme/app_palette.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';

import '../../../widgets/confs_bottom_nav_bar.dart';
import '../../../widgets/empty_list_info.dart';
import '../../settings/presentation/connection_status.dart';
import 'widgets/speaker_tile.dart';

class SpeakersPage extends StatefulWidget {
  const SpeakersPage({super.key});

  @override
  State<SpeakersPage> createState() => _SpeakersPageState();
}

class _SpeakersPageState extends State<SpeakersPage> with ConnectivityMixin {
  late final SpeakersCubit _speakersCubit;
  EventItemType _eventItemType = EventItemType.ngPoland;

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
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            actions: const [ConnectionStatus()],
          ),
          body: ColoredBox(
            color: context.palette.screen,
            child: state.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error) => const EmptyListInformation(),
              loaded: (listSpeakers) {
                final key = conferenceKeyForTrack(_eventItemType);
                final visible = [
                  for (final speaker in listSpeakers)
                    if (speaker.conferenceKey == key) speaker,
                ];
                if (visible.isEmpty) return const EmptyListInformation();
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: visible.length,
                  itemBuilder: (context, index) => SpeakerTile(visible[index]),
                );
              },
              orElse: () => const SizedBox.shrink(),
            ),
          ),
          showBottomNavigationBar: true,
          bottomNavigationBar: ConfsBottomNavigationBar(
            selectedType: _eventItemType,
            onItemTapped: (type) => setState(() => _eventItemType = type),
          ),
        );
      },
    );
  }
}
