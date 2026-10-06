import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/entities/event_item.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/logic/conference_datetime.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/widgets/event.dart';

class ScheduleEventsList extends StatefulWidget {
  final List<EventItem> listEvents;
  final EventItemType eventItemType;

  const ScheduleEventsList({
    super.key,
    required this.listEvents,
    required this.eventItemType,
  });

  @override
  State<ScheduleEventsList> createState() => _ScheduleEventsListState();
}

class _ScheduleEventsListState extends State<ScheduleEventsList>
    with WidgetsBindingObserver {
  Timer? _timer;
  final ValueNotifier<String?> _activeEventIdNotifier =
      ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    _checkActiveEvent();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didUpdateWidget(covariant ScheduleEventsList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.listEvents, widget.listEvents)) {
      _checkActiveEvent();
    }
  }

  List<({String id, DateTime? start, DateTime? end})> get _slots => [
        for (final event in widget.listEvents)
          (id: event.id, start: event.startDate, end: event.endDate),
      ];

  void _checkActiveEvent() {
    _timer?.cancel();
    final listEvents = widget.listEvents;
    if (listEvents.isEmpty) {
      _activeEventIdNotifier.value = null;
      return;
    }

    final now = DateTime.now().toUtc();
    _activeEventIdNotifier.value = activeScheduleEventId(
      events: _slots,
      now: now,
    );

    final nextCheck = nextActiveScheduleCheckAt(events: _slots, now: now);
    if (nextCheck == null) return;

    final delay = nextCheck.difference(now);
    if (delay.isNegative || delay == Duration.zero) {
      // Clock / data edge: retry shortly instead of spinning.
      _timer = Timer(const Duration(seconds: 1), _checkActiveEvent);
      return;
    }

    _timer = Timer(delay, _checkActiveEvent);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkActiveEvent();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    _activeEventIdNotifier.dispose();
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      itemCount: widget.listEvents.length,
      itemBuilder: (context, index) {
        return ValueListenableBuilder(
          valueListenable: _activeEventIdNotifier,
          builder: (context, activeEvent, _) {
            return ScheduleEvent(
              eventItem: widget.listEvents[index],
              eventItemType: widget.eventItemType,
              iconColor: Theme.of(context).colorScheme.tertiary,
              isActiveEvent: activeEvent == widget.listEvents[index].id,
            );
          },
        );
      },
    );
  }
}
