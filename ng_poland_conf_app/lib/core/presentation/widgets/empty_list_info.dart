import 'package:flutter/material.dart';

class EmptyListInformation extends StatelessWidget {
  const EmptyListInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.titleMedium;
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          Icon(
            Icons.update,
            size: 85,
            color: theme.colorScheme.secondary.withValues(alpha: 0.7),
          ),
          Padding(
            padding: const .all(32),
            child: Text(
              'Sorry, no results returned.\nPlease check the Internet connection.',
              textAlign: .center,
              style: titleStyle?.copyWith(
                color: titleStyle.color?.withValues(alpha: 0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
