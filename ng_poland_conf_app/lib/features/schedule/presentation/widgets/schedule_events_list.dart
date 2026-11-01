import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ng_poland_conf_app/core/presentation/theme/app_palette.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/schedule/domain/services/schedule_timeline.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/hooks/use_active_schedule_event.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/widgets/event.dart';

class ScheduleEventsList extends HookWidget {
  final List<EventItem> listEvents;
  final EventItemType eventItemType;

  const ScheduleEventsList({
    super.key,
    required this.listEvents,
    required this.eventItemType,
  });

  @override
  Widget build(BuildContext context) {
    final slots = useMemoized(
      () => [
        for (final event in listEvents)
          (id: event.id, start: event.startDate, end: event.endDate),
      ],
      [listEvents],
    );
    final activeEvent = useActiveScheduleEvent(slots);
    final now = DateTime.now();
    final phase = scheduleDayPhase(
      events: slots,
      now: now,
      inSlot: activeEvent != null,
    );

    return ColoredBox(
      color: context.palette.screen,
      child: ListView.builder(
        padding: const .only(top: 8, bottom: 24),
        itemCount: listEvents.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _ScheduleStatusBar(
              phase: phase,
              zoneLabel: warsawZoneLabel(now),
            );
          }
          final event = listEvents[index - 1];
          return ScheduleEvent(
            eventItem: event,
            eventItemType: eventItemType,
            isActiveEvent: activeEvent == event.id,
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
      .upcoming => 'CONFERENCE UPCOMING',
      .ongoing => 'CONFERENCE ONGOING',
      .ended => 'CONFERENCE ENDED',
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
