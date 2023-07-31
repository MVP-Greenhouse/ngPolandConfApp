import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
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
          body: _buildBody(context, state),
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
              state.maybeWhen(
                initial: () => const Text('data'),
                loaded: (conferences, selectedConference) => Text(selectedConference.confName),
                orElse: () => const SizedBox.shrink(),
              ),
              const SizedBox(
                height: 30.0,
              ),
              ValueListenableBuilder(
                valueListenable: _cubit.timeToStartConferenceNotifier,
                builder: (context, int timeToStartConference, _) {
                  return CustomTimer(
                    toStart: Duration(
                      seconds: timeToStartConference,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
