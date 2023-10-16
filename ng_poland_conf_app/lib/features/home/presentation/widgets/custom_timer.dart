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
          context,
          value: duration.inDays,
          unit: 'days',
          color: const Color.fromRGBO(255, 0, 122, 1),
        ),
        _buildTile(
          context,
          value: duration.inHours.remainder(24),
          unit: 'hours',
          color: const Color.fromRGBO(255, 193, 7, 1),
        ),
        _buildTile(
          context,
          value: duration.inMinutes.remainder(60),
          unit: 'minutes',
          color: const Color.fromRGBO(0, 193, 193, 1),
        ),
        _buildTile(
          context,
          value: duration.inSeconds.remainder(60),
          unit: 'seconds',
          color: const Color.fromRGBO(139, 195, 74, 1),
        ),
      ],
    );
  }

  Widget _buildTile(
    BuildContext context, {
    required int value,
    required String unit,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 26.0,
                color: color,
              ),
        ),
        Text(
          unit.toUpperCase(),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color, fontWeight: FontWeight.w400, fontSize: 12.0),
        ),
      ],
    );
  }
}
