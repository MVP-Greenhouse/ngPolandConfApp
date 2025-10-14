import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/entities/event_item.dart';
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

class _ScheduleEventsListState extends State<ScheduleEventsList> with WidgetsBindingObserver {
  Timer? _timer;
  final ValueNotifier<String?> _activeEventIdNotifier = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    _checkActiveEvent(widget.listEvents);
    WidgetsBinding.instance.addObserver(this);
  }

  bool checkTimeEventToAnimation(
    DateTime dateNow,
    DateTime? dateStartEvent,
    DateTime? dateEndEvent,
  ) {
    if (dateStartEvent == null || dateEndEvent == null) return false;

    return dateStartEvent.toUtc().millisecondsSinceEpoch < dateNow.toUtc().millisecondsSinceEpoch &&
        dateNow.toUtc().millisecondsSinceEpoch < dateEndEvent.toUtc().millisecondsSinceEpoch;
  }

  void _checkActiveEvent(List<EventItem> listEvents) {
    _timer?.cancel();
    List<EventItem> listEventsToShow = [];
    _activeEventIdNotifier.value = null;
    if (listEvents.isEmpty) return;

    final dateNow = DateTime.now().toUtc();
    // Dodaj do listy tylko przyszle eventy
    for (var event in listEvents) {
      final dateStartEvent = event.startDate?.toUtc();
      final dateEndEvent = event.endDate?.toUtc();
      if (dateStartEvent == null || dateEndEvent == null) continue;
      if (dateEndEvent.isBefore(dateNow)) continue;

      if (checkTimeEventToAnimation(dateNow, dateStartEvent, dateEndEvent)) {
        _activeEventIdNotifier.value = event.id;
        continue;
      }
      listEventsToShow.add(event);
    }
    // Jezeli nie ma wiecej eventow do wyswietlenia to ustaw timer na koniec ostatniego eventu
    if (listEventsToShow.isEmpty) {
      final lastEventEndDate = listEvents.last.endDate?.toUtc();
      if (lastEventEndDate == null) return;
      _timer = Timer(
        lastEventEndDate.difference(dateNow),
        () => _checkActiveEvent(listEventsToShow),
      );
      return;
    }

    // Wykonaj ponownie przy nastepnym evencie
    final nextEvent = listEventsToShow.first;
    final nextEventStartDate = nextEvent.startDate?.toUtc();
    if (nextEventStartDate == null) return;
    _timer = Timer(
      nextEventStartDate.difference(dateNow),
      () => _checkActiveEvent(listEventsToShow),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkActiveEvent(widget.listEvents);
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
