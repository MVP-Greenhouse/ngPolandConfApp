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
        final scheme = Theme.of(context).colorScheme;
        return CustomScaffold(
          appBar: AppBar(
            title: Text(
              'Nagrody',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: scheme.inversePrimary,
              ),
            ),
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, PrizesState state) {
    if (state.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      itemCount: state.prizes.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) => _PrizeCard(prize: state.prizes[index]),
    );
  }
}

class _PrizeCard extends StatelessWidget {
  const _PrizeCard({required this.prize});

  final UserPrize prize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final accent = isDark ? scheme.primaryContainer : scheme.secondary;

    final finishedAt = prize.finishedAt;
    final placeLine = finishedAt == null
        ? 'Miejsce ${prize.order}'
        : 'Miejsce ${prize.order} • '
              '${DateFormat('dd.MM.yyyy').format(finishedAt.toLocal())}';

    return Material(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: scheme.outline.withValues(alpha: isDark ? 0.28 : 0.12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: isDark ? 0.25 : 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.emoji_events,
                  size: 22,
                  color: accent,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      prize.contestName,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      placeLine,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 13,
                        color: scheme.onSurface.withValues(alpha: 0.65),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
