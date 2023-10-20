import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/features/nggirls/presentation/cubit/ngGirls_cubit.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';

class NgGirlsPage extends StatefulWidget {
  const NgGirlsPage({super.key});

  @override
  State<NgGirlsPage> createState() => _NgGirlsPageState();
}

class _NgGirlsPageState extends State<NgGirlsPage> {
  late final NgGirlsCubit _ngGirlsCubit;

  @override
  void initState() {
    _ngGirlsCubit = getIt.get<NgGirlsCubit>();
    _ngGirlsCubit.getNgGirls();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: BlocBuilder<NgGirlsCubit, NgGirlsState>(
        bloc: _ngGirlsCubit,
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (ngGirls) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      ngGirls.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(ngGirls.text, style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
