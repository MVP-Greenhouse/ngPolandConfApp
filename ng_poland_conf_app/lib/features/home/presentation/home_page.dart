import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/core/constants/app_dimensions.dart';
import 'package:ng_poland_conf_app/features/home/presentation/widgets/custom_timer.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/widgets/custom_dropdown.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';

import '../../settings/presentation/connection_status.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ConferencesCubit _cubit;
  ConnectivityResult connectivityResult = ConnectivityResult.none;
  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    _cubit = getIt.get<ConferencesCubit>();
    super.initState();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        connectivityResult = result;
      });
    });
  }

  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConferencesCubit, ConferencesState>(
      bloc: _cubit,
      builder: (context, state) {
        return CustomScaffold(
          appBar: AppBar(
            title: Text(
              'NG & JS Poland',
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
            : MediaQuery.of(context).size.height * 3, // This line makes the widget take 100% height
        child: SizedBox(
          child: Column(
            children: [
              const SizedBox(
                height: 30.0,
              ),
              AnimatedSize(
                alignment: Alignment.topCenter,
                duration: const Duration(milliseconds: 300),
                child: state.maybeWhen(
                  initial: () => Text('The Biggest Angular Conference',
                      textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer.withAlpha(200))),
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
              const Divider(
                height: 60.0,
              ),
              state.maybeWhen(
                loaded: (conferences, selectedConference) => Column(
                  children: selectedConference.listItems
                      .map(
                        (e) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  color: Theme.of(context).colorScheme.onPrimaryContainer.withAlpha(150),
                                  size: 16.0,
                                ),
                                const SizedBox(
                                  width: 12.0,
                                ),
                                Text(e.desc,
                                    style:
                                        Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer.withAlpha(170), fontSize: 16.0))
                              ],
                            ),
                            const SizedBox(
                              height: 6.0,
                            ),
                            Text(
                              e.name,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.secondary),
                            ),
                            const SizedBox(
                              height: 18.0,
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
                orElse: () => const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
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
