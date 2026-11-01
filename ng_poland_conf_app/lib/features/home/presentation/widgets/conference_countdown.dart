import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ng_poland_conf_app/core/presentation/hooks/use_countdown.dart';

/// Days / hours / minutes / seconds until the conference starts.
class ConferenceCountdown extends HookWidget {
  const ConferenceCountdown({super.key, required this.startsAt});

  final DateTime? startsAt;

  @override
  Widget build(BuildContext context) {
    final left = useCountdown(startsAt);

    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        _CountdownTile(
          value: left.inDays,
          unit: 'days',
          color: const Color.fromRGBO(255, 0, 122, 1),
        ),
        _CountdownTile(
          value: left.inHours.remainder(24),
          unit: 'hours',
          color: const Color.fromRGBO(255, 193, 7, 1),
        ),
        _CountdownTile(
          value: left.inMinutes.remainder(60),
          unit: 'minutes',
          color: const Color.fromRGBO(0, 193, 193, 1),
        ),
        _CountdownTile(
          value: left.inSeconds.remainder(60),
          unit: 'seconds',
          color: const Color.fromRGBO(139, 195, 74, 1),
        ),
      ],
    );
  }
}

class _CountdownTile extends StatelessWidget {
  const _CountdownTile({
    required this.value,
    required this.unit,
    required this.color,
  });

  final int value;
  final String unit;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          '$value',
          style: textTheme.titleMedium?.copyWith(
            fontWeight: .w700,
            fontSize: 26,
            color: color,
          ),
        ),
        Text(
          unit.toUpperCase(),
          style: textTheme.bodySmall?.copyWith(
            color: color,
            fontWeight: .w400,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
