import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/core/mixins/connectivity_mixin.dart';
import 'package:ng_poland_conf_app/features/edition/domains/entities/agenda.dart';
import 'package:ng_poland_conf_app/features/edition/domains/entities/edition.dart';
import 'package:ng_poland_conf_app/features/edition/presentation/edition_cubit.dart';
import 'package:ng_poland_conf_app/features/workshops/presentation/widgets/workshop_card.dart';
import 'package:ng_poland_conf_app/features/workshops/presentation/widgets/workshops_bottom_nav_bar.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/theme/app_palette.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';
import 'package:ng_poland_conf_app/widgets/empty_list_info.dart';

import '../../settings/presentation/connection_status.dart';

class WorkshopsPage extends StatefulWidget {
  const WorkshopsPage({super.key, this.initialDayKey, this.initialWorkshopId});

  final String? initialDayKey;
  final int? initialWorkshopId;

  @override
  State<WorkshopsPage> createState() => _WorkshopsPageState();
}

class _WorkshopsPageState extends State<WorkshopsPage> with ConnectivityMixin {
  late final EditionCubit _editionCubit;
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _workshopKeys = {};
  String? _dayKey;
  int? _pendingScrollId;
  bool _scrollScheduled = false;

  @override
  void initState() {
    super.initState();
    _editionCubit = getIt.get<EditionCubit>();
    _dayKey = widget.initialDayKey;
    _pendingScrollId = widget.initialWorkshopId;
    _editionCubit.ensure();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(WorkshopsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialDayKey != oldWidget.initialDayKey &&
        widget.initialDayKey != null) {
      _dayKey = widget.initialDayKey;
    }
    if (widget.initialWorkshopId != oldWidget.initialWorkshopId ||
        widget.initialDayKey != oldWidget.initialDayKey) {
      _pendingScrollId = widget.initialWorkshopId;
      _scrollScheduled = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EditionState>(
      stream: _editionCubit.stream,
      initialData: _editionCubit.state,
      builder: (context, _) {
        final edition = _editionCubit.current;
        final days = [
          for (final day in edition?.days ?? const <AgendaDay>[])
            if (day.kind == AgendaDayKind.workshops) day,
        ];
        final resolved = _dayContaining(_pendingScrollId, days);
        if (resolved != null) _dayKey = resolved.key;
        final selected =
            resolved ??
            days.where((day) => day.key == _dayKey).firstOrNull ??
            days.firstOrNull;

        return CustomScaffold(
          appBar: AppBar(
            title: Text(
              'Workshops',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            actions: const [ConnectionStatus()],
          ),
          body: ColoredBox(
            color: context.palette.screen,
            child: _body(edition, selected),
          ),
          showBottomNavigationBar: days.isNotEmpty,
          bottomNavigationBar: days.isEmpty
              ? const SizedBox.shrink()
              : WorkshopsBottomNavigationBar(
                  days: days,
                  selectedKey: selected?.key ?? days.first.key,
                  onSelected: (day) => setState(() {
                    _dayKey = day.key;
                    _pendingScrollId = null;
                  }),
                ),
        );
      },
    );
  }

  Widget _body(Edition? edition, AgendaDay? selected) {
    if (edition == null) {
      return switch (_editionCubit.state) {
        EditionFailed() => const EmptyListInformation(),
        _ => const Center(child: CircularProgressIndicator()),
      };
    }
    if (selected == null) return const EmptyListInformation();
    if (selected.workshopItems.isEmpty) {
      return const Center(child: Text('No workshops announced yet'));
    }
    final pendingId = _pendingScrollId;
    if (pendingId != null) {
      _workshopKeys.putIfAbsent(pendingId, GlobalKey.new);
    }
    _scheduleScroll(selected);
    return ListView.builder(
      controller: _scrollController,
      itemCount: selected.workshopItems.length,
      itemBuilder: (context, index) {
        final workshop = selected.workshopItems[index];
        return WorkshopCard(
          key: _workshopKeys[workshop.id],
          workshop: workshop,
        );
      },
    );
  }

  AgendaDay? _dayContaining(int? workshopId, List<AgendaDay> days) {
    if (workshopId == null) return null;
    for (final day in days) {
      if (day.workshopItems.any((item) => item.id == workshopId)) return day;
    }
    return null;
  }

  void _scheduleScroll(AgendaDay selected) {
    final id = _pendingScrollId;
    if (id == null || _scrollScheduled) return;
    _scrollScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        if (!mounted || _pendingScrollId != id) return;
        await _revealWorkshop(id, selected);
      } finally {
        _scrollScheduled = false;
      }
    });
  }

  Future<void> _revealWorkshop(int id, AgendaDay selected) async {
    if (!selected.workshopItems.any((item) => item.id == id)) {
      _pendingScrollId = null;
      return;
    }
    final key = _workshopKeys.putIfAbsent(id, GlobalKey.new);
    if (key.currentContext == null && _scrollController.hasClients) {
      _scrollController.jumpTo(0);
      await WidgetsBinding.instance.endOfFrame;
      if (!mounted || _pendingScrollId != id) return;
    }
    for (var attempt = 0; attempt < 24; attempt++) {
      if (!mounted || _pendingScrollId != id) return;
      final target = key.currentContext;
      if (target != null && target.mounted) {
        await Scrollable.ensureVisible(
          target,
          alignment: 0.08,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
        );
        if (mounted) _pendingScrollId = null;
        return;
      }
      if (!_scrollController.hasClients) return;
      final position = _scrollController.position;
      final next = math.min(
        position.maxScrollExtent,
        position.pixels + position.viewportDimension * 0.85,
      );
      if ((next - position.pixels).abs() < 1) break;
      _scrollController.jumpTo(next);
      await WidgetsBinding.instance.endOfFrame;
    }
    _pendingScrollId = null;
  }
}
