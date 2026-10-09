import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/schedule_top5_page.dart';
import 'package:ng_poland_conf_app/routing/routing.dart';
import 'package:ng_poland_conf_app/theme/app_palette.dart';

class ScheduleVotingBanner extends StatelessWidget {
  const ScheduleVotingBanner({
    super.key,
    required this.track,
    required this.votingOpen,
    required this.top5Enabled,
  });

  final EventItemType track;
  final bool votingOpen;
  final bool top5Enabled;

  /// Height of this banner, including its padding, for [AppBar.bottom].
  static double barExtent(BuildContext context) {
    final textDirection = Directionality.of(context);
    final textScaler = MediaQuery.textScalerOf(context);
    final titleStyle =
        Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: 0.2,
          fontSize: 13,
        ) ??
        const TextStyle(fontSize: 13, fontWeight: FontWeight.w800);
    final subtitleStyle =
        Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12) ??
        const TextStyle(fontSize: 12);
    final textWidth = math.max(0.0, MediaQuery.sizeOf(context).width - 124);
    final titleHeight = _textHeight(
      'LIVE VOTING IS OPEN!',
      titleStyle,
      textDirection,
      textScaler,
      textWidth,
    );
    final subtitleHeight = _textHeight(
      'Vote for your favorite talks • Top 5 ranking',
      subtitleStyle,
      textDirection,
      textScaler,
      textWidth,
    );
    final contentHeight = math.max(32, titleHeight + 4 + subtitleHeight);
    return (44 + contentHeight).ceilToDouble();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    const closedAccent = Color(0xFFFFC107);
    final highlight = votingOpen ? palette.accent : closedAccent;
    final canOpenTop5 = top5Enabled;

    final title = votingOpen ? 'LIVE VOTING IS OPEN!' : 'VOTING CLOSED';
    final String subtitle;
    if (!votingOpen) {
      subtitle = 'See the official Top 5 ranking';
    } else if (top5Enabled) {
      subtitle = 'Vote for your favorite talks • Top 5 ranking';
    } else {
      subtitle = 'Vote for your favorite talks';
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: canOpenTop5
              ? () {
                  context.pushNamed(
                    '${Pages.schedule.nameKey}-${ScheduleTop5Page.routeNameKey}',
                    pathParameters: {'eventItemType': track.name},
                  );
                }
              : null,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: palette.card,
              border: Border.all(
                color: highlight.withValues(alpha: votingOpen ? 0.55 : 0.45),
                width: 1.4,
              ),
              boxShadow: [
                BoxShadow(
                  color: highlight.withValues(alpha: 0.16),
                  blurRadius: 16,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: highlight.withValues(alpha: 0.16),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      votingOpen
                          ? Icons.bolt_rounded
                          : Icons.emoji_events_rounded,
                      size: 18,
                      color: highlight,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.2,
                                color: highlight,
                                fontSize: 13,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(fontSize: 12, color: palette.muted),
                        ),
                      ],
                    ),
                  ),
                  if (canOpenTop5)
                    Icon(Icons.arrow_forward, size: 20, color: palette.muted),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

double _textHeight(
  String text,
  TextStyle style,
  TextDirection textDirection,
  TextScaler textScaler,
  double maxWidth,
) {
  final painter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: textDirection,
    textScaler: textScaler,
    maxLines: 2,
  )..layout(maxWidth: maxWidth);
  final height = painter.height;
  painter.dispose();
  return height;
}
