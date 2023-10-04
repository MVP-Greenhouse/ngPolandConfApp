import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/core/constants/app_dimensions.dart';
import 'package:ng_poland_conf_app/features/home/presentation/widgets/custom_timer.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/widgets/custom_dropdown.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ConferencesCubit _cubit;

  @override
  void initState() {
    _cubit = getIt.get<ConferencesCubit>();
    getIt.get<ConferencesCubit>().getConferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConferencesCubit, ConferencesState>(
      bloc: _cubit,
      builder: (context, state) {
        return CustomScaffold(
          appBar: AppBar(
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
            ],
          ),
          body: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 24.0,
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
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
      child: Column(
        children: [
          Column(
            children: [
              AnimatedSize(
                alignment: Alignment.topCenter,
                duration: const Duration(milliseconds: 200),
                child: state.maybeWhen(
                  initial: () => const Text('The Biggest Angular Conference'),
                  loaded: (conferences, selectedConference) => Text(
                    selectedConference.description,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  orElse: () => const SizedBox.shrink(),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              _buildTimer(),
              Divider(
                height: 30.0,
              ),
              state.maybeWhen(
                loaded: (conferences, selectedConference) => Column(
                  children: selectedConference.listItems
                      .map(
                        (e) => Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.calendar_month),
                                SizedBox(
                                  width: 12.0,
                                ),
                                Text(
                                  e.desc,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6.0,
                            ),
                            Text(
                              e.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(
                              height: 12.0,
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
        ],
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
