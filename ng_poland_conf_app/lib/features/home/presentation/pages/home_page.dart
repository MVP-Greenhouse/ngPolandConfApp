import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/core/constants/app_dimensions.dart';
import 'package:ng_poland_conf_app/core/presentation/navigation/app_pages.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/connection_status.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/custom_scaffold.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/conference.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/conference_item.dart';
import 'package:ng_poland_conf_app/features/edition/domain/services/conference_tracks.dart';
import 'package:ng_poland_conf_app/features/edition/domain/services/edition_projections.dart';
import 'package:ng_poland_conf_app/features/home/domain/services/home_schedule_navigation.dart';
import 'package:ng_poland_conf_app/features/home/presentation/cubit/conferences_cubit.dart';
import 'package:ng_poland_conf_app/features/home/presentation/widgets/conference_countdown.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final conference = context.select(
      (ConferencesCubit cubit) => cubit.state.selected,
    );
    final theme = Theme.of(context);

    return CustomScaffold(
      appBar: AppBar(
        title: Text(
          conferenceDisplayName(conference?.confId),
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.inversePrimary,
          ),
        ),
        actions: const [ConnectionStatus()],
      ),
      body: Container(
        padding: const .all(24),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_blured.jpg'),
            fit: .cover,
          ),
        ),
        child: _HomeBody(conference: conference),
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({required this.conference});

  final Conference? conference;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    final taglineStyle = theme.textTheme.titleLarge?.copyWith(
      color: theme.colorScheme.onPrimaryContainer.withAlpha(200),
    );

    return Center(
      child: SizedBox(
        // Full screen height in portrait so the list can scroll as one page.
        height: mediaQuery.orientation == .portrait
            ? mediaQuery.size.height
            : double.infinity,
        child: ListView(
          children: [
            const SizedBox(height: 30),
            AnimatedSize(
              alignment: .topCenter,
              duration: const Duration(milliseconds: 300),
              child: Text(
                conference?.description ?? editionTagline,
                textAlign: .center,
                style: taglineStyle,
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: .symmetric(
                horizontal: AppDimensions.padding.defaultHorizontal,
              ),
              child: ConferenceCountdown(startsAt: conference?.startsAt),
            ),
            const SizedBox(height: 50),
            for (final item
                in conference?.listItems ?? const <ConferenceItem>[])
              _HomeScheduleItem(item: item),
          ],
        ),
      ),
    );
  }
}

class _HomeScheduleItem extends StatelessWidget {
  const _HomeScheduleItem({required this.item});

  final ConferenceItem item;

  void _open(BuildContext context) {
    final location = switch (HomeScheduleNavigation.targetForDayKey(item.key)) {
      HomeScheduleNavTarget(destination: .schedule, :final track?) =>
        '${Pages.schedule.path}?track=${track.name}',
      HomeScheduleNavTarget(destination: .workshops, :final dayKey) =>
        '${Pages.workshops.path}?day=$dayKey',
      _ => null,
    };
    if (location != null) context.go(location);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Row(
          mainAxisAlignment: .center,
          children: [
            Icon(
              Icons.calendar_month,
              color: scheme.onPrimaryContainer.withAlpha(150),
              size: 16,
            ),
            const SizedBox(width: 12),
            Text(
              item.desc,
              style: textTheme.titleMedium?.copyWith(
                color: scheme.onPrimaryContainer.withAlpha(170),
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: () => _open(context),
          borderRadius: .circular(6),
          child: Padding(
            padding: const .symmetric(horizontal: 8, vertical: 4),
            child: Text(
              item.name,
              style: textTheme.titleMedium?.copyWith(color: scheme.secondary),
            ),
          ),
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}
