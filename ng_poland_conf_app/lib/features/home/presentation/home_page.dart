import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/core/constants/app_dimensions.dart';
import 'package:ng_poland_conf_app/core/mixins/connectivity_mixin.dart';
import 'package:ng_poland_conf_app/features/home/domains/logic/home_schedule_navigation.dart';
import 'package:ng_poland_conf_app/features/home/presentation/widgets/custom_timer.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/routing/routing.dart';
import 'package:ng_poland_conf_app/widgets/custom_dropdown.dart';
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
            actions: [
              state.maybeWhen(
                loaded: (conferences, selectedConference) => CustomDropDown(
                  options: conferences.list
                      .map(
                        (conference) => conference.confId,
                      )
                      .toList(),
                  selectedOption: selectedConference.confId,
                  onChanged: (String? confId) => confId != null ? _cubit.changeConference(confId) : null,
                ),
                orElse: () => const SizedBox.shrink(),
              ),
              const ConnectionStatus(),
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
                loaded: (conferences, selectedConference) => Column(
                  children: [
                    for (final item in selectedConference.listItems)
                      _HomeScheduleItem(
                        date: item.desc,
                        name: item.name,
                        onTap: () => _openScheduleItem(context, item.name),
                      ),
                  ],
                ),
                orElse: () => const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openScheduleItem(BuildContext context, String name) {
    final target = HomeScheduleNavigation.targetForName(name);
    if (target == null) return;

    final base = switch (target.destination) {
      HomeScheduleDestination.schedule => Pages.schedule.path,
      HomeScheduleDestination.workshops => Pages.workshops.path,
    };
    context.go('$base?track=${target.track.name}');
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
