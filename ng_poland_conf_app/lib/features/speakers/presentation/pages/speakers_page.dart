import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/core/presentation/theme/app_palette.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/connection_status.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/custom_scaffold.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/empty_list_info.dart';
import 'package:ng_poland_conf_app/features/home/presentation/widgets/track_navigation_bar.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/cubit/speakers_cubit.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/widgets/speaker_tile.dart';

/// Speakers of a track. Expects a [SpeakersCubit] above it.
class SpeakersPage extends StatelessWidget {
  const SpeakersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SpeakersCubit>().state;
    final theme = Theme.of(context);

    return CustomScaffold(
      appBar: AppBar(
        title: Text(
          'Speakers',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.inversePrimary,
          ),
        ),
        actions: const [ConnectionStatus()],
      ),
      body: ColoredBox(
        color: context.palette.screen,
        child: switch (state) {
          SpeakersLoading() => const Center(child: CircularProgressIndicator()),
          SpeakersFailed() ||
          SpeakersLoaded(speakers: []) => const EmptyListInformation(),
          SpeakersLoaded(:final speakers) => ListView.builder(
            padding: const .symmetric(vertical: 12),
            itemCount: speakers.length,
            itemBuilder: (context, index) => SpeakerTile(speakers[index]),
          ),
        },
      ),
      showBottomNavigationBar: true,
      bottomNavigationBar: TrackNavigationBar(
        selectedType: state.track,
        onItemTapped: context.read<SpeakersCubit>().selectTrack,
      ),
    );
  }
}
