import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/features/edition/domains/entities/agenda.dart';

class WorkshopsBottomNavigationBar extends StatelessWidget {
  const WorkshopsBottomNavigationBar({
    super.key,
    required this.days,
    required this.selectedKey,
    required this.onSelected,
  });

  final List<AgendaDay> days;
  final String selectedKey;
  final ValueChanged<AgendaDay> onSelected;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = days.indexWhere((day) => day.key == selectedKey);
    final currentIndex = selectedIndex >= 0 ? selectedIndex : 0;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        for (final day in days) _item(day),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Theme.of(context).colorScheme.inversePrimary,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      onTap: (index) => onSelected(days[index]),
    );
  }

  String _label(AgendaDay day) {
    final name = day.homeName;
    const suffix = ' Day';
    if (name.endsWith(suffix) && name.length > suffix.length) {
      return name.substring(0, name.length - suffix.length).toUpperCase();
    }
    return name.toUpperCase();
  }

  BottomNavigationBarItem _item(AgendaDay day) {
    final selected = day.key == selectedKey;
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 5),
        child: Opacity(
          opacity: selected ? 1 : 0.5,
          child: _WorkshopDayMark(dateLabel: day.dateLabel),
        ),
      ),
      label: _label(day),
    );
  }
}

class _WorkshopDayMark extends StatelessWidget {
  const _WorkshopDayMark({required this.dateLabel});

  final String dateLabel;

  @override
  Widget build(BuildContext context) {
    final parts = dateLabel.split(',').first.trim().split(' ');
    final month = parts.first;
    final day = parts.length > 1 ? parts[1] : '';

    return SizedBox(
      height: 40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            month,
            style: TextStyle(
              color: IconTheme.of(context).color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.1,
            ),
          ),
          if (day.isNotEmpty)
            Text(
              day,
              style: TextStyle(
                color: IconTheme.of(context).color,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                height: 1.1,
              ),
            ),
        ],
      ),
    );
  }
}
