import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ng_poland_conf_app/core/presentation/theme/app_palette.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/connection_status.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/custom_scaffold.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/empty_list_info.dart';
import 'package:ng_poland_conf_app/features/workshops/domain/entities/workshop_day.dart';
import 'package:ng_poland_conf_app/features/workshops/presentation/cubit/workshops_cubit.dart';
import 'package:ng_poland_conf_app/features/workshops/presentation/widgets/workshop_card.dart';
import 'package:ng_poland_conf_app/features/workshops/presentation/widgets/workshops_bottom_nav_bar.dart';

/// Workshops grouped by day. Expects a [WorkshopsCubit] above it.
class WorkshopsPage extends HookWidget {
  const WorkshopsPage({super.key, this.initialDayKey, this.initialWorkshopId});

  final String? initialDayKey;
  final int? initialWorkshopId;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WorkshopsCubit>();
    useEffect(() {
      cubit.focus(dayKey: initialDayKey, workshopId: initialWorkshopId);
      return null;
    }, [initialDayKey, initialWorkshopId]);
    final state = context.watch<WorkshopsCubit>().state;
    final theme = Theme.of(context);
    final days = switch (state) {
      WorkshopsLoaded(:final days) => days,
      _ => const <WorkshopDay>[],
    };

    return CustomScaffold(
      appBar: AppBar(
        title: Text(
          'Workshops',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.inversePrimary,
          ),
        ),
        actions: const [ConnectionStatus()],
      ),
      body: ColoredBox(
        color: context.palette.screen,
        child: switch (state) {
          WorkshopsLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
          WorkshopsFailed() ||
          WorkshopsLoaded(selected: null) => const EmptyListInformation(),
          WorkshopsLoaded(selected: WorkshopDay(workshops: [])) => const Center(
            child: Text('No workshops announced yet'),
          ),
          WorkshopsLoaded(:final selected?, :final pendingScrollId) =>
            _WorkshopList(day: selected, scrollToId: pendingScrollId),
        },
      ),
      showBottomNavigationBar: days.isNotEmpty,
      bottomNavigationBar: switch (state) {
        WorkshopsLoaded(:final days, :final selected) when days.isNotEmpty =>
          WorkshopsBottomNavigationBar(
            days: days,
            selectedKey: selected?.key ?? days.first.key,
            onSelected: (day) => cubit.selectDay(day.key),
          ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}

class _WorkshopList extends HookWidget {
  const _WorkshopList({required this.day, required this.scrollToId});

  final WorkshopDay day;
  final int? scrollToId;

  /// How many viewport jumps to try while looking for a lazily built card.
  static const _maxRevealAttempts = 24;

  /// Fraction of the viewport scrolled per attempt (keeps some overlap).
  static const _revealStep = 0.85;

  /// Where the revealed card lands in the viewport (0 = top).
  static const _revealAlignment = 0.08;

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    final keys = useMemoized(() => <int, GlobalKey>{});
    final cubit = context.read<WorkshopsCubit>();
    useEffect(() {
      final id = scrollToId;
      if (id == null) return null;
      var cancelled = false;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await _reveal(
          controller,
          keys.putIfAbsent(id, GlobalKey.new),
          () => cancelled,
        );
        if (!cancelled) cubit.scrollHandled();
      });
      return () => cancelled = true;
    }, [scrollToId, day.key]);

    return ListView.builder(
      controller: controller,
      itemCount: day.workshops.length,
      itemBuilder: (context, index) {
        final item = day.workshops[index];
        return WorkshopCard(key: keys[item.workshop.id], item: item);
      },
    );
  }

  /// Scrolls until the card with [key] is built, then brings it into view.
  static Future<void> _reveal(
    ScrollController controller,
    GlobalKey key,
    bool Function() cancelled,
  ) async {
    if (key.currentContext == null && controller.hasClients) {
      controller.jumpTo(0);
      await WidgetsBinding.instance.endOfFrame;
    }
    for (var attempt = 0; attempt < _maxRevealAttempts; attempt++) {
      if (cancelled()) return;
      if (key.currentContext case final target? when target.mounted) {
        await Scrollable.ensureVisible(
          target,
          alignment: _revealAlignment,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
        );
        return;
      }
      if (!controller.hasClients) return;
      final position = controller.position;
      final next = math.min(
        position.maxScrollExtent,
        position.pixels + position.viewportDimension * _revealStep,
      );
      if ((next - position.pixels).abs() < 1) return;
      controller.jumpTo(next);
      await WidgetsBinding.instance.endOfFrame;
    }
  }
}
