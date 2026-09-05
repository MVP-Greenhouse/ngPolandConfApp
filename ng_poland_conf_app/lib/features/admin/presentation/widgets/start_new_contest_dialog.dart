import 'package:flutter/material.dart';

class StartNewContestResult {
  const StartNewContestResult({
    required this.name,
    required this.carryParticipants,
  });

  final String name;
  final bool carryParticipants;
}

class StartNewContestDialog extends StatefulWidget {
  const StartNewContestDialog({super.key});

  @override
  State<StartNewContestDialog> createState() => _StartNewContestDialogState();
}

class _StartNewContestDialogState extends State<StartNewContestDialog> {
  late final TextEditingController _nameController;
  bool _carryParticipants = false;
  String? _nameError;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() => _nameError = 'Podaj nazwę konkursu');
      return;
    }
    Navigator.of(context).pop(
      StartNewContestResult(name: name, carryParticipants: _carryParticipants),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nowy konkurs'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            autofocus: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _submit(),
            decoration: InputDecoration(
              labelText: 'Nazwa konkursu',
              errorText: _nameError,
            ),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Przenieś uczestników'),
            value: _carryParticipants,
            onChanged: (value) {
              setState(() => _carryParticipants = value);
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Anuluj'),
        ),
        FilledButton(onPressed: _submit, child: const Text('Utwórz')),
      ],
    );
  }
}
