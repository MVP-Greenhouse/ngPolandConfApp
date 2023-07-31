import 'package:flutter/material.dart';

class CustomTimer extends StatelessWidget {
  final Duration toStart;

  const CustomTimer({
    super.key,
    required this.toStart,
  });

  @override
  Widget build(BuildContext context) {
    return _buildBody(
      context,
      duration: toStart.inSeconds > 0 ? toStart : const Duration(),
    );
  }

  Widget _buildBody(
    BuildContext context, {
    required Duration duration,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTile(
          value: duration.inDays,
          unit: 'days',
          color: Theme.of(context).colorScheme.primary,
        ),
        _buildTile(
          value: duration.inHours.remainder(24),
          unit: 'hours',
          color: Theme.of(context).colorScheme.primary,
        ),
        _buildTile(
          value: duration.inMinutes.remainder(60),
          unit: 'minutes',
          color: Theme.of(context).colorScheme.primary,
        ),
        _buildTile(
          value: duration.inSeconds.remainder(60),
          unit: 'seconds',
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }

  Widget _buildTile({
    required int value,
    required String unit,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: TextStyle(
            color: color,
          ),
        ),
        Text(
          unit.toUpperCase(),
          style: TextStyle(
            color: color,
          ),
        ),
      ],
    );
  }
}
