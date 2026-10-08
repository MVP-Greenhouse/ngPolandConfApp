import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/entities/event_item.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/logic/conference_datetime.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/widgets/event.dart';
import 'package:ng_poland_conf_app/theme/app_palette.dart';

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
  final ValueNotifier<String?> _activeEventIdNotifier = ValueNotifier<String?>(
    null,
  );

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
    final palette = context.palette;
    return ColoredBox(
      color: palette.screen,
      child: ValueListenableBuilder<String?>(
        valueListenable: _activeEventIdNotifier,
        builder: (context, activeEvent, _) {
          final phase = scheduleDayPhase(
            events: [
              for (final slot in _slots) (start: slot.start, end: slot.end),
            ],
            now: DateTime.now().toUtc(),
            inSlot: activeEvent != null,
          );
          return ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 24),
            itemCount: widget.listEvents.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return _ScheduleStatusBar(
                  phase: phase,
                  zoneLabel: warsawZoneLabel(DateTime.now()),
                );
              }
              final event = widget.listEvents[index - 1];
              return ScheduleEvent(
                eventItem: event,
                eventItemType: widget.eventItemType,
                isActiveEvent: activeEvent == event.id,
              );
            },
          );
        },
      ),
    );
  }
}

class _ScheduleStatusBar extends StatelessWidget {
  const _ScheduleStatusBar({required this.phase, required this.zoneLabel});

  final ScheduleDayPhase phase;
  final String zoneLabel;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final ongoing = phase == ScheduleDayPhase.ongoing;
    final label = switch (phase) {
      ScheduleDayPhase.upcoming => 'CONFERENCE UPCOMING',
      ScheduleDayPhase.ongoing => 'CONFERENCE ONGOING',
      ScheduleDayPhase.ended => 'CONFERENCE ENDED',
    };
    final color = ongoing ? palette.accent : palette.muted;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 14),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: const SizedBox.square(dimension: 8),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.1,
            ),
          ),
          const Spacer(),
          Text(
            zoneLabel,
            style: TextStyle(
              color: palette.muted,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
