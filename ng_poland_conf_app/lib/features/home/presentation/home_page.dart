import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/core/constants/app_dimensions.dart';
import 'package:ng_poland_conf_app/core/mixins/connectivity_mixin.dart';
import 'package:ng_poland_conf_app/features/home/domains/logic/home_schedule_navigation.dart';
import 'package:ng_poland_conf_app/features/edition/domains/entities/edition.dart';
import 'package:ng_poland_conf_app/features/edition/presentation/edition_cubit.dart';
import 'package:ng_poland_conf_app/features/home/presentation/widgets/custom_timer.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/routing/routing.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';

import '../../settings/presentation/connection_status.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with ConnectivityMixin {
  late final ConferencesCubit _cubit;

  @override
  void initState() {
    _cubit = getIt.get<ConferencesCubit>();
    super.initState();
    Connectivity().checkConnectivity().then((results) {
      if (!mounted || results.isEmpty) return;
      setState(() {
        connectivityResult = results.last;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConferencesCubit, ConferencesState>(
      bloc: _cubit,
      builder: (context, state) {
        return CustomScaffold(
          appBar: AppBar(
            title: Text(
              _getTitleForConference(
                state.mapOrNull(
                  loaded: (value) => value.selectedConference.confId,
                ),
              ),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.inversePrimary),
            ),
            actions: const [
              ConnectionStatus(),
            ],
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 24.0,
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_blured.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: _buildBody(context, state),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, ConferencesState state) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).orientation == Orientation.portrait
            ? MediaQuery.of(context).size.height
            : double.infinity, // This line makes the widget take 100% height
        child: SizedBox(
          child: ListView(
            children: [
              const SizedBox(
                height: 30.0,
              ),
              AnimatedSize(
                alignment: Alignment.topCenter,
                duration: const Duration(milliseconds: 300),
                child: state.maybeWhen(
                  initial: () => Text('The Biggest Angular Conference',
                      textAlign: TextAlign.center,
                      style:
                          Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer.withAlpha(200))),
                  loaded: (conferences, selectedConference) => Text(
                    selectedConference.description ?? '',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer.withAlpha(200)),
                  ),
                  orElse: () => const SizedBox.shrink(),
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              _buildTimer(),
              const SizedBox(
                height: 50.0,
              ),
              state.maybeWhen(
                loaded: (_, _) {
                  final edition = getIt.get<EditionCubit>().current;
                  if (edition == null) return const SizedBox.shrink();
                  return Column(
                    children: [
                      for (final row in homeScheduleRows(edition))
                        _HomeScheduleItem(
                          date: row.dateLabel,
                          name: row.name,
                          onTap: () => _openScheduleItem(context, row),
                        ),
                    ],
                  );
                },
                orElse: () => const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openScheduleItem(BuildContext context, HomeScheduleRow row) {
    final target = HomeScheduleNavigation.targetForDayKey(row.key);
    if (target == null) return;
    final location = switch (target.destination) {
      HomeScheduleDestination.schedule =>
        '${Pages.schedule.path}?track=${target.track?.name}',
      HomeScheduleDestination.workshops =>
        '${Pages.workshops.path}?day=${target.dayKey}',
    };
    context.go(location);
  }

  String _getTitleForConference(String? confId) {
    final defaultTitle = 'NG & JS Poland';
    try {
      if (confId == null || confId.isEmpty) return defaultTitle;
      final int confIdInt = int.parse(confId);
      if (confIdInt < 2025) return defaultTitle;

      return 'NG & JS & AI Poland';
    } catch (_) {
      return defaultTitle;
    }
  }

  Widget _buildTimer() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.padding.defaultHorizontal,
      ),
      child: ValueListenableBuilder(
        valueListenable: _cubit.timeToStartConferenceNotifier,
        builder: (context, int timeToStartConference, _) {
          return CustomTimer(
            toStart: Duration(
              seconds: timeToStartConference,
            ),
          );
        },
      ),
    );
  }
}

class _HomeScheduleItem extends StatelessWidget {
  const _HomeScheduleItem({
    required this.date,
    required this.name,
    required this.onTap,
  });

  final String date;
  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_month,
              color: scheme.onPrimaryContainer.withAlpha(150),
              size: 16.0,
            ),
            const SizedBox(width: 12.0),
            Text(
              date,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: scheme.onPrimaryContainer.withAlpha(170),
                    fontSize: 16.0,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: scheme.secondary,
                  ),
            ),
          ),
        ),
        const SizedBox(height: 18.0),
      ],
    );
  }
}
