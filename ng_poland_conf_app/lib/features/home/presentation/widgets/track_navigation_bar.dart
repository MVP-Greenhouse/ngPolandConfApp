import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/home/presentation/cubit/conferences_cubit.dart';

/// Bottom navigation between the tracks of the current conference.
class TrackNavigationBar extends StatelessWidget {
  const TrackNavigationBar({
    super.key,
    required this.onItemTapped,
    required this.selectedType,
  });

  final ValueChanged<EventItemType> onItemTapped;
  final EventItemType selectedType;

  @override
  Widget build(BuildContext context) {
    final types = context.select(
      (ConferencesCubit cubit) => cubit.state.availableEventTypes,
    );
    final selectedIndex = types.indexOf(selectedType);

    return BottomNavigationBar(
      items: [
        for (final type in types)
          BottomNavigationBarItem(
            icon: _TrackIcon(type: type, selected: type == selectedType),
            label: type.label,
          ),
      ],
      currentIndex: selectedIndex >= 0 ? selectedIndex : 0,
      selectedItemColor: Theme.of(context).colorScheme.inversePrimary,
      selectedLabelStyle: const TextStyle(fontWeight: .bold),
      onTap: (index) => onItemTapped(types[index]),
    );
  }
}

class _TrackIcon extends StatelessWidget {
  const _TrackIcon({required this.type, required this.selected});

  final EventItemType type;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .only(top: 20, bottom: 5),
      child: SizedBox(
        height: 40,
        child: Opacity(
          opacity: selected ? 1 : 0.5,
          child: FittedBox(
            fit: .fill,
            child: Image.asset(type.imagePath, height: 20, width: 20),
          ),
        ),
      ),
    );
  }
}
