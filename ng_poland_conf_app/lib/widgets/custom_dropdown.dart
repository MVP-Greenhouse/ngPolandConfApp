import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final List<String> options;
  late final String _selectedOption;
  final Function(String?) onChanged;

  CustomDropDown({
    required this.options,
    required String selectedOption,
    required this.onChanged,
    super.key,
  }) {
    _selectedOption = options.contains(selectedOption) ? selectedOption : options.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedOption,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.green),
      underline: Container(
        height: 2,
        color: Colors.greenAccent,
      ),
      onChanged: onChanged,
      items: options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
