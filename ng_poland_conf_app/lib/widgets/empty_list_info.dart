import 'package:flutter/material.dart';

class EmptyListInformation extends StatelessWidget {
  const EmptyListInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.update,
                size: 85,
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  'Sorry, no results returned.\nPlease check the Internet connection.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).textTheme.titleMedium?.color?.withOpacity(0.7)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
