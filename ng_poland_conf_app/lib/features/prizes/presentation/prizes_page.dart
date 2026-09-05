import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/user_prize.dart';
import 'package:ng_poland_conf_app/features/prizes/presentation/cubit/prizes_cubit.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/routing/routing.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';

class PrizesPage extends StatelessWidget {
  const PrizesPage({super.key});

  static const path = '/prizes';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PrizesCubit, PrizesState>(
      bloc: getIt.get<PrizesCubit>(),
      listenWhen: (previous, current) =>
          previous.loading != current.loading ||
          previous.hasPrizes != current.hasPrizes,
      listener: (context, state) {
        if (!state.loading && !state.hasPrizes) {
          context.go(Pages.home.path);
        }
      },
      builder: (context, state) {
        return CustomScaffold(
          appBar: AppBar(title: const Text('Nagrody')),
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(PrizesState state) {
    if (state.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      itemCount: state.prizes.length,
      separatorBuilder: (_, _) => const Divider(),
      itemBuilder: (context, index) => _PrizeTile(prize: state.prizes[index]),
    );
  }
}

class _PrizeTile extends StatelessWidget {
  const _PrizeTile({required this.prize});

  final UserPrize prize;

  @override
  Widget build(BuildContext context) {
    final finishedAt = prize.finishedAt;
    final subtitle = finishedAt == null
        ? 'Miejsce ${prize.order}'
        : 'Miejsce ${prize.order} • '
              '${DateFormat('dd.MM.yyyy').format(finishedAt.toLocal())}';

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      leading: Icon(
        Icons.emoji_events,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(prize.contestName),
      subtitle: Text(subtitle),
    );
  }
}
