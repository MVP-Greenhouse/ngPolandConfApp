import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/features/workshops/domain/entities/workshop_day.dart';

class WorkshopsBottomNavigationBar extends StatelessWidget {
  const WorkshopsBottomNavigationBar({
    super.key,
    required this.days,
    required this.selectedKey,
    required this.onSelected,
  });

  final List<WorkshopDay> days;
  final String selectedKey;
  final ValueChanged<WorkshopDay> onSelected;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = days.indexWhere((day) => day.key == selectedKey);

    return BottomNavigationBar(
      type: .fixed,
      items: [
        for (final day in days)
          BottomNavigationBarItem(
            icon: _WorkshopDayIcon(day: day, selected: day.key == selectedKey),
            label: day.tabLabel,
          ),
      ],
      currentIndex: selectedIndex >= 0 ? selectedIndex : 0,
      selectedItemColor: Theme.of(context).colorScheme.inversePrimary,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      selectedLabelStyle: const TextStyle(fontWeight: .bold),
      onTap: (index) => onSelected(days[index]),
    );
  }
}

class _WorkshopDayIcon extends StatelessWidget {
  const _WorkshopDayIcon({required this.day, required this.selected});

  final WorkshopDay day;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final color = IconTheme.of(context).color;
    return Padding(
      padding: const .only(top: 20, bottom: 5),
      child: Opacity(
        opacity: selected ? 1 : 0.5,
        child: SizedBox(
          height: 40,
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Text(
                day.month,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: .w600,
                  height: 1.1,
                ),
              ),
              if (day.dayOfMonth.isNotEmpty)
                Text(
                  day.dayOfMonth,
                  style: TextStyle(
                    color: color,
                    fontSize: 16,
                    fontWeight: .bold,
                    height: 1.1,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
