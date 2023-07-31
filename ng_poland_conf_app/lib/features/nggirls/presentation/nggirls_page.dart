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
            loaded: (ngGirls) => Column(
              children: [
                Text(ngGirls.title),
                const SizedBox(
                  height: 30,
                ),
                Text(ngGirls.text),
              ],
            ),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
