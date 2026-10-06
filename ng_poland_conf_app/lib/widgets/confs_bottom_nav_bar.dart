import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';

class ConfsBottomNavigationBar extends StatelessWidget {
  const ConfsBottomNavigationBar({
    super.key,
    required this.onItemTapped,
    required this.selectedType,
  });

  final Function(EventItemType) onItemTapped;
  final EventItemType selectedType;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConferencesCubit, ConferencesState>(
      builder: (_, state) {
        final types = state.availableEventTypes;
        final selectedIndex = types.indexOf(selectedType);
        final currentIndex = selectedIndex >= 0 ? selectedIndex : 0;

        return BottomNavigationBar(
          items: [
            for (final type in types) _buildItem(type),
          ],
          currentIndex: currentIndex,
          selectedItemColor: Theme.of(context).colorScheme.inversePrimary,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          onTap: (index) => onItemTapped(types[index]),
        );
      },
    );
  }

  BottomNavigationBarItem _buildItem(EventItemType eventItemType) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 5,
        ),
        child: SizedBox(
          height: 40,
          child: Opacity(
            opacity: eventItemType == selectedType ? 1.0 : 0.5,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image.asset(
                eventItemType.imagePath,
                height: 20,
                width: 20,
              ),
            ),
          ),
        ),
      ),
      label: eventItemType.label,
    );
  }
}
