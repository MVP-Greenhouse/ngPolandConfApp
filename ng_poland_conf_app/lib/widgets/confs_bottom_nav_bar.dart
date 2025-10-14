import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';

class ConfsBottomNavigationBar extends StatefulWidget {
  const ConfsBottomNavigationBar({super.key, required this.onItemTapped});
  final Function(EventItemType) onItemTapped;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  State<ConfsBottomNavigationBar> createState() => _ConfsBottomNavigationBarState();
}

class _ConfsBottomNavigationBarState extends State<ConfsBottomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped({
    required int index,
    required List<EventItemType> availableEventTypes,
  }) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onItemTapped(availableEventTypes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConferencesCubit, ConferencesState>(
      builder: (_, state) => BottomNavigationBar(
        items: state.availableEventTypes
            .map(
              (type) => _buildItem(type),
            )
            .toList(),
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.inversePrimary,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        onTap: (index) => _onItemTapped(
          index: index,
          availableEventTypes: state.availableEventTypes,
        ),
      ),
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
            opacity: eventItemType == EventItemType.values[_selectedIndex] ? 1.0 : 0.5,
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
