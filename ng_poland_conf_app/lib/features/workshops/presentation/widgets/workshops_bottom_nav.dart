import 'package:flutter/material.dart';

class WorkshopsBottomNavigationBar extends StatefulWidget {
  const WorkshopsBottomNavigationBar({super.key, required this.onItemTapped});
  final Function(int) onItemTapped;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  State<WorkshopsBottomNavigationBar> createState() => _WorkshopsBottomNavigationBarState();
}

class _WorkshopsBottomNavigationBarState extends State<WorkshopsBottomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onItemTapped(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Container(
            padding: const EdgeInsets.only(top: 20, bottom: 5),
            child: SizedBox(
              height: 40,
              child: Opacity(
                opacity: _selectedIndex == 0 ? 1 : 0.3,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset('assets/images/ngpolandlogo.png'), // replace with your image path
                ),
              ),
            ),
          ),
          label: 'NG POLAND',
        ),
        BottomNavigationBarItem(
          icon: Container(
            padding: const EdgeInsets.only(top: 20, bottom: 5),
            child: SizedBox(
              height: 40,
              child: Opacity(
                opacity: _selectedIndex == 1 ? 1 : 0.3,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset('assets/images/jspolandlogo.png'), // replace with your image path
                ),
              ),
            ),
          ),
          label: 'JS POLAND',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Theme.of(context).colorScheme.inversePrimary,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      onTap: _onItemTapped,
    );
  }
}
