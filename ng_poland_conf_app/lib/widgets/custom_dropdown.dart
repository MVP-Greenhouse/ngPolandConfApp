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
    this.tooltip = 'Select the conference year',
    super.key,
  }) {
    _selectedOption = options.contains(selectedOption) ? selectedOption : options.first;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24.0),
      child: PopupMenuButton<String>(
        initialValue: _selectedOption,
        iconSize: 24.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        tooltip: tooltip,
        splashRadius: 10,
        icon: Row(
          children: [
            const Icon(Icons.arrow_drop_down),
            Container(
              alignment: Alignment.center,
              child: Text(
                _selectedOption,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18.0, color: Theme.of(context).colorScheme.onPrimaryContainer.withAlpha(200)),
              ),
            ),
          ],
        ),
        onSelected: onChanged,
        itemBuilder: (BuildContext context) => options
            .map(
              (option) => PopupMenuItem<String>(
                padding: const EdgeInsets.only(left: 20.0),
                value: option,
                child: Text(
                  option,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
