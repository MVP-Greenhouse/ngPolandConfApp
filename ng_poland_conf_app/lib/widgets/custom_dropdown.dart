import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final List<String> options;
  late final String _selectedOption;
  final Function(String?) onChanged;
  final String tooltip;

  CustomDropDown({
    required this.options,
    required String selectedOption,
    required this.onChanged,
    this.tooltip = 'Menu',
    super.key,
  }) {
    _selectedOption = options.contains(selectedOption) ? selectedOption : options.first;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      initialValue: _selectedOption,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      tooltip: tooltip,
      splashRadius: 10,
      icon: Container(
        alignment: Alignment.center,
        width: 60,
        child: Text(
          _selectedOption,
        ),
      ),
      onSelected: onChanged,
      itemBuilder: (BuildContext context) => options
          .map(
            (option) => PopupMenuItem<String>(
              value: option,
              child: Text(option),
            ),
          )
          .toList(),
    );
  }
}
