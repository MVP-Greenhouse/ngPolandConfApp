import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/datasources/models/conferences.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/routing/Routing.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Hello World!'),
            TextButton(
              onPressed: () {
                context.go(Pages.info.path);
              },
              child: const Text('New screen'),
            ),
            BlocBuilder<ConferencesCubit, ConferencesState>(
              bloc: getIt.get<ConferencesCubit>(),
              builder: (context, state) {
                return Column(
                  children: [
                    state.when(
                      initial: () => Text('data'),
                      loaded: (Conferences conferences) => Text(conferences.confName),
                    ),
                    TextButton(
                      onPressed: () async {
                        await getIt.get<ConferencesCubit>().getConferences();
                      },
                      child: Text('Check'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
